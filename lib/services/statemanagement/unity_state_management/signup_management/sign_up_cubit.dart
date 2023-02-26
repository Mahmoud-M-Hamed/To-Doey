import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/components/toast/toast_helper.dart';
import 'package:todoey/models/user_info_model/user_info_model.dart';
import 'package:todoey/services/statemanagement/shared_management/shared_instance_management.dart';
import '../../../../styles/icons/broken_icons.dart';
import '../../../firebase_services_management/firebase_services.dart';
import '../../shared_management/shared_models_management.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpStates>
    with ModelInstances, GetLocalImagesFromFireBase, FirebaseServices {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  //------------------------------<Design UI>------------------------------------------\\
  IconData hideEyeConfirmPassword = BrokenIcons.hide;
  bool isConfirmPasswordShown = true;

  void toggleHideEyeConfirmPasswordIconState() {
    if (isConfirmPasswordShown) {
      hideEyeConfirmPassword = BrokenIcons.show;
    } else {
      hideEyeConfirmPassword = BrokenIcons.hide;
    }
    isConfirmPasswordShown = !isConfirmPasswordShown;
    emit(ToggleEyeIconSuccessState());
  }

  //------------------------------<Firebase back-end>-------------------------------\\

  Future<void> createUserAuth({
    required final String userName,
    required final String email,
    required final String password,
    required final String phoneNumber,
  }) async {
    emit(SignUpCreateUserLoadingState());
    await firebaseAuth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .whenComplete(() async {
          userInfoModel = UserInfoModel(
              userId: firebaseAuth.currentUser!.uid,
              userName: userName,
              email: email,
              phoneNumber: phoneNumber,
              signInMethod: 'EmailAndPassword');

          emit(SignUpCreateUserSuccessState());
        })
        .then((value) => setDataInFirebase(
            collectionPath: 'usersInfo',
            docId: firebaseAuth.currentUser!.uid,
            map: userInfoModel.userInfoToMap()))
        .catchError((e) {
          emit(SignUpCreateUserErrorState());
          showToast(message: 'Something wrong, Please try with another E-Mail');
        });
  }
}
