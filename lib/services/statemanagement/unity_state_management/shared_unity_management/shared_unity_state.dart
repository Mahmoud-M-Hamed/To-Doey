import 'package:flutter/foundation.dart';

@immutable
abstract class SharedUnityStates {}

class SharedUnityInitialState extends SharedUnityStates {}

//------------------------<Toggle Eye Icon>--------------------------------------------

class ToggleEyeIconSuccessState extends SharedUnityStates {}

//------------------------<Toggle Modal Progress Hud>--------------------------------------------

class ToggleModalProgressHudSuccessState extends SharedUnityStates {}

//------------------------<Get Local Images States>-----------------------------------------

class GetLocalImagesLoadingState extends SharedUnityStates {}

class GetLocalImagesSuccessState extends SharedUnityStates {}

class GetLocalImagesErrorState extends SharedUnityStates {}
