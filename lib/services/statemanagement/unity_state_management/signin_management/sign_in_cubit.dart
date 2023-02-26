// ignore_for_file: invalid_return_type_for_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/components/toast/toast_helper.dart';
import 'package:todoey/models/user_info_model/user_info_model.dart';
import 'package:todoey/services/facebook_services_management/facebook_management.dart';
import 'package:todoey/services/google_services_management/google_management.dart';
import 'package:todoey/services/sharedpreferences/sharedpreferences_service.dart';
import '../../../firebase_services_management/firebase_services.dart';
import '../../shared_management/shared_models_management.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInStates>
    with GoogleServices, FacebookServices, FirebaseServices, ModelInstances {
  SignInCubit() : super(SignInInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);

  //------------------------------------<Design UI>-------------------------------------------------
  bool checkboxState = false;

  void toggleCheckboxState({required bool checkboxState}) {
    this.checkboxState = checkboxState;
    SharedPreferencesHelper.saveDataAtSharedPref(
        key: 'checkboxState', value: this.checkboxState);
    emit(ToggleCheckboxSuccessState());
  }

  // --------------------------------<Firebase back-end>----------------------------------------

  Future<void> userAuthentication({
    required String email,
    required String password,
  }) async {
    emit(SignInUserAuthLoadingState());
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (value.user!.uid == firebaseAuth.currentUser!.uid) {
        emit(SignInUserAuthSuccessState());
        showToast(
          message: '$email is Signing In Successfully',
        );
      }
    }).catchError((e) {
      emit(SignInUserAuthErrorState());
      showToast(message: e.toString());
    });
  }

  Future<void> userAuthenticationWithGoogle() async {
    emit(GoogleSignInLoadingState());
    await userAuthWithGoogle().then((value) {
      User user = value.user!;
      userInfoModel = UserInfoModel(
          userId: user.uid,
          userName: user.displayName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          userImage: user.photoURL,
          signInMethod: 'Google');
      setDataInFirebase(
          collectionPath: 'usersInfo',
          docId: user.uid,
          map: userInfoModel.userInfoToMap());
      emit(GoogleSignInSuccessState());
      showToast(message: '${user.email} is Signing In Successfully');
    }).catchError((e) {
      emit(GoogleSignInErrorState());
      showToast(message: e.toString());
    });
  }

  Future<void> userAuthenticationWithFacebook() async {
    emit(FacebookSignInLoadingState());
    await userAuthWithFacebook().then((value) {
      User user = value.user!;
      userInfoModel = UserInfoModel(
          userId: user.uid,
          userName: user.displayName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          userImage: user.photoURL,
          signInMethod: 'Facebook');
      setDataInFirebase(
          collectionPath: 'usersInfo',
          docId: user.uid,
          map: userInfoModel.userInfoToMap());
      emit(FacebookSignInSuccessState());
      showToast(message: '${user.email} is Signing In Successfully');
    }).catchError((e) {
      emit(FacebookSignInErrorState());
      showToast(message: e.toString());
    });
  }
}
