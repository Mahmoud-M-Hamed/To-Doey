import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/alertdialog/showalertdialog.dart';
import 'package:todoey/components/toast/toast_helper.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_cubit.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_state.dart';
import 'package:todoey/styles/icons/broken_icons.dart';
import 'package:workmanager/workmanager.dart';

// ignore: must_be_immutable
class TaskListTile extends StatelessWidget {
  int? index;

  TaskListTile({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoeyCubit, TodoeyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoeyCubit todoeyCubit = TodoeyCubit.get(context);

        if(state is GetTasksSuccessState){
          for (var task in todoeyCubit.tasksList) {
            if(!(todoeyCubit
                .fromDateTimeToDuration(
              dateTimeParsing: todoeyCubit.notificationDateTime(
                  dateToParse: '${task.taskDate}',
                  timeToParse: '${task.taskTime}'),
            ).inSeconds*-1).isNegative){
              Workmanager().registerOneOffTask(
                  initialDelay: Duration(
                    seconds: todoeyCubit
                        .fromDateTimeToDuration(
                      dateTimeParsing: todoeyCubit.notificationDateTime(
                          dateToParse: '${task.taskDate}',
                          timeToParse: '${task.taskTime}'),
                    )
                        .inSeconds *
                        -1,
                  ),
                  task.taskTitle.toString(),
                  "simpleTask",
                  inputData: {
                    'title': task.taskTitle.toString(),
                    'body': 'It\'s Task Time...',
                  });
            }
          }
        }

        return ListTile(
          title: Text(
            todoeyCubit.tasksList[index!].taskTitle.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: (!todoeyCubit.tasksList[index!].isDone)
                    ? TextDecoration.none
                    : TextDecoration.lineThrough),
          ),
          subtitle: Row(
            children: [
              Text(
                '${todoeyCubit.tasksList[index!].taskDate} at ',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38,
                ),
              ),
              Text(
                '${todoeyCubit.tasksList[index!].taskTime}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  BrokenIcons.trash,
                  color: Colors.red,
                ),
                onPressed: () {
                  showAlertDialog(
                    context: context,
                    barrierDismissible: true,
                    title: 'Delete Confirmation!',
                    content: Text(
                      'Are you sure you want delete '
                      '(${todoeyCubit.tasksList[index!].taskTitle}) ?',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await todoeyCubit
                              .deleteTaskFromFirebase(docIdIndex: index)
                              .whenComplete(
                            () {
                                Navigator.of(context).pop();
                              showToast(
                                message: 'Task Deleted Successfully',
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Checkbox(
                value: todoeyCubit.tasksList[index!].isDone,
                onChanged: (checkboxState) {
                  todoeyCubit.toggleCheckboxState(
                      checkboxState: checkboxState!, isDoneIndex: index!);
                  todoeyCubit.sendCheckboxStateToFirebase(
                      checkboxValue: checkboxState, docIdIndex: index!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
