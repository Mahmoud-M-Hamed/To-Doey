import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/services/firebase_services_management/firebase_task_services.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_state.dart';
import 'package:todoey/services/timehandel/time_handeler_service.dart';
import '../../../models/task_model/task_model.dart';
import '../../controller_services/controller_mixins.dart';
import '../shared_management/shared_models_management.dart';

class TodoeyCubit extends Cubit<TodoeyStates>
    with Controllers, ModelInstances, TimeAndDateHandler, FirebaseTaskServices {
  TodoeyCubit() : super(TodoeyInitialState());

  static TodoeyCubit get(context) => BlocProvider.of(context);

  //-----------------------------------<Variables>------------------------------------------

  List<TaskModel> tasksList = [];
  List docIdList = [];

  //-----------------------------------<Design UI>------------------------------------------

  void toggleCheckboxState(
      {required bool checkboxState, required int isDoneIndex}) {
    tasksList[isDoneIndex].isDone = checkboxState ??= false;
    emit(ToggleCheckboxState());
  }

  //-----------------------------------<Firebase Stuff>------------------------------------------

  //-----------------------------------<checkbox>------------------------------------------

  void sendCheckboxStateToFirebase(
          {required bool checkboxValue, required int docIdIndex}) =>
      userTasksReference.get().then((value) {
        getDocID();
        userTasksReference
            .doc(docIdList[docIdIndex])
            .update({'isDone': checkboxValue});
      });

  //-----------------------------------<Get User Data>------------------------------------------

  Future<void> getDocID() async =>
      userTasksReference.snapshots().listen((value) {
        docIdList = [];
        value.docs.map((e) => docIdList.add(e.id)).toList();
      });

  void getTasksData() {
    firebaseFirestore
        .collection('usersInfo')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('userTasks')
        .snapshots()
        .listen((events) {
      tasksList = [];
      for (var element in events.docs) {
        taskModel = TaskModel.fromJson(element.data());
        tasksList.add(taskModel);
      }
      emit(GetTasksSuccessState());
    });
  }

  //-----------------------------------<Send User Data>------------------------------------------

  Future<void> sendTaskToFirebase() async => await setTaskInFirebase(
          dateTime: dateTimeHandler(
              dateFormatPattern: 'yyyy-MM-dd HH:mm:ss',
              dateTime: DateTime.now()),
          map: {
            'taskTitle': addTaskController.text,
            'taskTime': taskTimeController.text,
            'taskDate': dateController.text,
            'isDone': false,
          });

  //-----------------------------------<Delete User Data>------------------------------------------

  Future<void> deleteTaskFromFirebase({required dynamic docIdIndex}) async =>
      await getDocID().whenComplete(() {
        userTasksReference
            .doc(docIdList[docIdIndex])
            .delete()
            .whenComplete(() => emit(DeleteSuccessState()))
            .catchError((e) => emit(DeleteErrorState()));
      });
}
