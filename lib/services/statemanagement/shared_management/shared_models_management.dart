import '../../../models/task_model/task_model.dart';
import '../../../models/unity_model/unity_model.dart';
import '../../../models/user_info_model/user_info_model.dart';

mixin ModelInstances {
  UserInfoModel? _userInfoModel;
  UnityLocalImagesModel? _unityLocalImagesModel;
  TaskModel? _taskModel;

  UserInfoModel get userInfoModel => _userInfoModel!;

  set userInfoModel(UserInfoModel userInfoModel) =>
      _userInfoModel = userInfoModel;

  UnityLocalImagesModel get unityLocalImagesModel => _unityLocalImagesModel!;

  set unityLocalImagesModel(UnityLocalImagesModel unityLocalImagesModel) =>
      _unityLocalImagesModel = unityLocalImagesModel;

  TaskModel get taskModel => _taskModel!;

  set taskModel(TaskModel taskModel) => _taskModel = taskModel;
}
