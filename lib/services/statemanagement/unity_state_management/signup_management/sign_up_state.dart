import 'package:flutter/foundation.dart';

@immutable
abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}


//------------------------<Toggle Eye Icon>--------------------------------------------

class ToggleEyeIconSuccessState extends SignUpStates {}

//------------------------<Create User States>-----------------------------------------

class SignUpCreateUserLoadingState extends SignUpStates {}

class SignUpCreateUserSuccessState extends SignUpStates {}

class SignUpCreateUserErrorState extends SignUpStates {}

//------------------------<Set User Info States>-----------------------------------------

class SignUpSetUserInfoLoadingState extends SignUpStates {}

class SignUpSetUserInfoSuccessState extends SignUpStates {}

class SignUpSetUserInfoErrorState extends SignUpStates {}
