import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/reusablecomponents/reusable_components.dart';
import 'package:todoey/components/toast/toast_helper.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_cubit.dart';
import '../../../../services/statemanagement/todoey_state_management/todoey_state.dart';

class BuildBottomSheet extends StatelessWidget {
  const BuildBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoeyCubit(),
      child: BlocConsumer<TodoeyCubit, TodoeyStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TodoeyCubit todoeyCubit = TodoeyCubit.get(context);
          return Container(
            height: 390,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Form(
                key: todoeyCubit.tasksFormKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    rTextField(
                        textEditingController: todoeyCubit.addTaskController,
                        labelText: 'Add Task',
                        prefixIcon: Icons.text_fields,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Task must not be empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    rTextField(
                      textEditingController: todoeyCubit.taskTimeController,
                      labelText: 'Time',
                      prefixIcon: Icons.watch_later_outlined,
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Time must not be empty';
                        }
                        return null;
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: TimeOfDay.now(),
                            onChange: (timeOfDay) {
                              todoeyCubit.taskTimeController.text =
                                  todoeyCubit.timeOfDayHandler(
                                      context: context, timeOfDay: timeOfDay);
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    rTextField(
                      textEditingController: todoeyCubit.dateController,
                      labelText: 'Select Date',
                      prefixIcon: Icons.date_range,
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Date must not be empty';
                        }
                        return null;
                      },
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse("2100-01-31"),
                        ).then((value) {
                          if (value == null) {
                            todoeyCubit.dateController.text = '';
                          } else {
                            todoeyCubit.dateController.text =
                                todoeyCubit.dateTimeHandler(
                                    dateFormatPattern: 'yyyy-MM-dd',
                                    dateTime: value);
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          if (todoeyCubit.tasksFormKey.currentState!
                              .validate()) {
                            await todoeyCubit
                                .sendTaskToFirebase()
                                .whenComplete(() {
                              Navigator.of(context).pop();
                              showToast(message: 'Task Added Successfully');
                            });
                          }
                        },
                        child: const Text('Add Task'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
