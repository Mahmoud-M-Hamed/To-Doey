import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/layouts/todoey_home/widgets/bottomsheet/show_bottom_sheet.dart';
import 'package:todoey/layouts/todoey_home/widgets/drawer_profile_activity.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_cubit.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_state.dart';
import 'package:todoey/styles/icons/broken_icons.dart';
import '../../components/animation/animated_text_kit.dart';
import 'widgets/tasks_view.dart';

class TodoeyHomeActivity extends StatelessWidget {
  const TodoeyHomeActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoeyCubit()
        ..getTasksData()
        ..getDocID(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kAppMainColor,
          appBar: AppBar(
            backgroundColor: kAppMainColor,
            elevation: 0,
            leadingWidth: 30,
            title: const Text(
              kAppMainName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          drawer: const DrawerProfile(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              BrokenIcons.plus_rec,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: const Color(0xff757575),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const BuildBottomSheet(),
                      ));
            },
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          BrokenIcons.tasks,
                          color: kAppMainColor,
                          size: 32,
                        ),
                      ),
                    ),
                    singleAnimatedText(
                      kAnimatedText: kAppMainName,
                      textStyle: todoeyColorizeTextStyle,
                      colors: kColorizeColors,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<TodoeyCubit, TodoeyStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return singleAnimatedText(
                          kAnimatedText:
                              '${TodoeyCubit.get(context).tasksList.length} Tasks To-do',
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: kAppFontFamily,
                          ),
                          colors: [Colors.white, Colors.cyan],
                          repeatedForever: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const TasksView(),
            ],
          ),
        ),
      ),
    );
  }
}
