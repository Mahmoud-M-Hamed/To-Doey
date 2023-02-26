import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/services/statemanagement/shared_management/shared_instance_management.dart';
import 'package:todoey/services/statemanagement/shared_management/shared_models_management.dart';
import '../../../../models/unity_model/unity_model.dart';
import '../../../../styles/icons/broken_icons.dart';
import '../../../controller_services/controller_mixins.dart';
import 'shared_unity_state.dart';

class SharedUnityCubit extends Cubit<SharedUnityStates>
    with Controllers, ModelInstances, GetLocalImagesFromFireBase {
  SharedUnityCubit() : super(SharedUnityInitialState());

  static SharedUnityCubit get(context) => BlocProvider.of(context);

  //------------------------------<Design UI>------------------------------------------\\
  IconData hideEyePassword = BrokenIcons.hide;
  bool isPasswordShown = true;
  bool isSaving = false;

  void toggleHideEyePasswordIconState() {
    if (isPasswordShown) {
      hideEyePassword = BrokenIcons.show;
    } else {
      hideEyePassword = BrokenIcons.hide;
    }
    isPasswordShown = !isPasswordShown;
    emit(ToggleEyeIconSuccessState());
  }

  set isSavingModalProgressHud(bool isSaving) {
    this.isSaving = isSaving;
    emit(ToggleModalProgressHudSuccessState());
  }

  //---------------------------------<Validation>--------------------------------------

  RegExp userNameValidation = RegExp(r"""
^[a-zA-Z0-9]+([_ -]?[a-zA-Z0-9])""", caseSensitive: false);

  RegExp emailValidation = RegExp(r"""
^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""",
      caseSensitive: false);

  RegExp passwordValidation = RegExp(r"""
^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$""",
      caseSensitive: true);

  String? userNameValidationFunction({required String validation}) {
    if (validation.isEmpty) return 'Please enter username';
    if (validation.length > 20 || validation.length <= 3) return 'username must be between 3-20 character';
    if (!userNameValidation.hasMatch(validation)) return 'Invalid username';
    return null;
  }

  String? phoneNumberValidation({required String validation}) {
    if (validation.isEmpty) return 'Please enter phone number';
    if (validation.length != 11) return 'Invalid phone number';
    return null;
  }

  String? emailValidationFunction({required String validation}) {
    if (validation.isEmpty) return 'Please enter email address';
    if (!emailValidation.hasMatch(validation)) return 'Invalid email address';
    return null;
  }

  String? passwordValidationFunction({required String validation}) {
    if (validation.isEmpty) return 'Please enter password';
    if (validation.length < 8) return 'Password too short';
    if (!passwordValidation.hasMatch(validation)) return 'Password is too weak, please add strength password';
    return null;
  }

  // ------------------------------------<Firebase Stuff>-----------------------------

  Future<void> get getUnityImagesFromFireBase async {
    emit(GetLocalImagesLoadingState());
    getLocalImagesFromFirebase.then((value) {
      unityLocalImagesModel = UnityLocalImagesModel.fromJson(value.data()!);
      emit(GetLocalImagesSuccessState());
    }).catchError((e) {
      emit(GetLocalImagesErrorState());
      return;
    });
  }
}
