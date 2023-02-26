import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/animation/spin_kit.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_cubit.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_state.dart';
import 'tasks_listtile.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> with DoubleBouncingAnimation {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoeyCubit, TodoeyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoeyCubit todoeyCubit = TodoeyCubit.get(context);
        return Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: (todoeyCubit.tasksList.isEmpty)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 50),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: todoeyCubit.tasksList.length,
                      itemBuilder: (context, index) =>
                          TaskListTile(index: index),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
