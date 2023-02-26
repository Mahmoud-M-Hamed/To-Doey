class TaskModel {
  String? taskTitle, taskTime, taskDate;
  bool isDone = false;

  TaskModel.fromJson(Map<String, dynamic> json) {
    taskTitle = json['taskTitle'];
    taskTime = json['taskTime'];
    taskDate = json['taskDate'];
    isDone = json['isDone'];
  }
}
