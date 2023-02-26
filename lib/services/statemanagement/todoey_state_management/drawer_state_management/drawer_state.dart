part of 'drawer_cubit.dart';

@immutable
abstract class DrawerStates {}

class DrawerInitialState extends DrawerStates {}

//-----------------------------------<Get User Data>-------------------------------------

class DrawerGetDataLoadingState extends DrawerStates {}

class DrawerGetDataSuccessState extends DrawerStates {}

class DrawerGetDataErrorState extends DrawerStates {}

//-----------------------------------<Get User Picture>-------------------------------------

class UploadImageLoadingState extends DrawerStates {}

class UploadImageSuccessState extends DrawerStates {}

class UploadImageErrorState extends DrawerStates {}

//-----------------------------------<pic User Picture>-------------------------------------

class PicImageSuccessState extends DrawerStates {}

class PicImageErrorState extends DrawerStates {}

//-----------------------------------<Remove Shared-Preferences Data>-------------------------------------

class RemoveSharedDataLoadingState extends DrawerStates {}

class RemoveSharedDataSuccessState extends DrawerStates {}

class RemoveSharedDataErrorState extends DrawerStates {}

//-----------------------------------<Remove User Data>-------------------------------------

class RemoveUserDataSuccessState extends DrawerStates {}

class RemoveUserDataErrorState extends DrawerStates {}

//-----------------------------------<Email Sign-out>-------------------------------------

class SignOutEmailSuccessState extends DrawerStates {}

class SignOutEmailErrorState extends DrawerStates {}

//-----------------------------------<Facebook Sign-out>-------------------------------------

class SignOutFacebookSuccessState extends DrawerStates {}

class SignOutFacebookErrorState extends DrawerStates {}

//-----------------------------------<Google Sign-out>-------------------------------------

class SignOutGoogleSuccessState extends DrawerStates {}

class SignOutGoogleErrorState extends DrawerStates {}

//-----------------------------------<Closing System>-------------------------------------

class CloseSystemSuccessState extends DrawerStates {}

class CloseSystemErrorState extends DrawerStates {}
