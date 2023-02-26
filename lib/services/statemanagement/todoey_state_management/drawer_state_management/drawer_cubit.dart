// ignore_for_file: invalid_return_type_for_catch_error
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/models/user_info_model/user_info_model.dart';
import 'package:todoey/services/facebook_services_management/facebook_management.dart';
import 'package:todoey/services/firebase_services_management/firebase_services.dart';
import 'package:todoey/services/google_services_management/google_management.dart';
import 'package:todoey/services/image_picker_services/image_picker_management.dart';
import 'package:todoey/services/statemanagement/shared_management/shared_models_management.dart';
import '../../../../components/toast/toast_helper.dart';
import '../../../sharedpreferences/sharedpreferences_service.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerStates>
    with
        ModelInstances,
        FirebaseServices,
        GoogleServices,
        FacebookServices,
        ImagePickerServices {
  DrawerCubit() : super(DrawerInitialState());

  static DrawerCubit get(context) => BlocProvider.of(context);

  //-------------------------------<Image Picker>---------------------------------------------

  Future<void> uploadImageToFirebase({required File file}) async =>
      await uploadImageHandler(file: file).then((value) {
        emit(UploadImageLoadingState());
        updateDataInFirebase(
                collectionPath: 'usersInfo',
                docId: firebaseAuth.currentUser!.uid,
                map: {'userImage': value})
            .whenComplete(() => emit(UploadImageSuccessState()));
      }).catchError((e) => emit(UploadImageErrorState()));

  Future<void> pickImageGallery() async => await imagePicker(
          imageSource: ImageSource.gallery,
          callback: (file) {
            if (file != null) profilePictureGallery = file;
          }).whenComplete(() {
        uploadImageToFirebase(file: profilePictureGallery!);
        emit(PicImageSuccessState());
      }).catchError((e) => emit(PicImageErrorState()));


  Future<void> pickImageCamera() async => await imagePicker(
          imageSource: ImageSource.camera,
          callback: (file) {
            if (file != null) profilePictureCamera = file;
          }).whenComplete(() {
        uploadImageToFirebase(file: profilePictureCamera!);
        emit(PicImageSuccessState());
      }).catchError((e) => emit(PicImageErrorState()));

  //----------------------------<Firebase back-end>---------------------------------------

  //-----------------------------<Get User Info From Firebase>-----------------------------------------
  void getUserInfo() {
    emit(DrawerGetDataLoadingState());
    getDataFromFirebase(
            collectionPath: 'usersInfo', docId: firebaseAuth.currentUser!.uid)
        .then((value) {
      userInfoModel = UserInfoModel.fromJson(value.data()!);
      emit(DrawerGetDataSuccessState());
    }).catchError((e) => emit(DrawerGetDataErrorState()));
  }

  //-----------------------------<User Sign-Out From Firebase>-----------------------------------------

  void removeSharedPref() =>
      SharedPreferencesHelper.removeData(key: 'token').then((value) async {
        SharedPreferencesHelper.removeData(key: 'checkboxState');
        emit(RemoveSharedDataSuccessState());
      }).catchError((e) {
        emit(RemoveSharedDataErrorState());
        showToast(message: e.toString());
      });

  Future<void> deleteDataFromFirebaseWithStates() async =>
      await deleteDataFromFirebase(
              collectionPath: 'usersInfo', docId: firebaseAuth.currentUser!.uid)
          .whenComplete(() {
        firebaseAuth.currentUser!.delete();
        emit(RemoveUserDataSuccessState());
      }).catchError((e) {
        showToast(message: e.toString());
        emit(RemoveUserDataErrorState());
      });

  Future<void> userAuthSignOut() async {
    removeSharedPref();
    await deleteDataFromFirebaseWithStates()
        .whenComplete(() async => await firebaseAuth.signOut().then((value) {
              emit(SignOutEmailSuccessState());
              showToast(message: 'Signing Out Successfully');
            }).catchError((e) {
              emit(SignOutEmailErrorState());
              showToast(message: e.toString());
            }));
  }

  //-----------------------------<Facebook Sign-Out>-----------------------------------------

  Future<void> facebookAuthSignOut() async {
    removeSharedPref();
    await deleteDataFromFirebaseWithStates()
        .whenComplete(() async => await firebaseAuth.signOut().then((value) {
              emit(SignOutFacebookSuccessState());
              showToast(message: 'Signing Out Successfully');
            }).catchError((e) {
              emit(SignOutFacebookErrorState());
              showToast(message: e.toString());
            }));
  }

  //-----------------------------<Google Sign-Out>-----------------------------------------

  Future<void> googleAuthSignOut() async {
    removeSharedPref();
    await deleteDataFromFirebaseWithStates()
        .whenComplete(() async => await firebaseAuth.signOut().then((value) {
              emit(SignOutGoogleSuccessState());
              showToast(message: 'Signing Out Successfully');
            }).catchError((e) {
              emit(SignOutGoogleErrorState());
              showToast(message: e.toString());
            }));
  }
}
