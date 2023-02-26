import 'package:flutter/foundation.dart';

@immutable
abstract class SignInStates {}

class SignInInitialState extends SignInStates {}

//------------------------<Design UI>---------------------------------
class ToggleCheckboxSuccessState extends SignInStates {}

//-------------------------------<User Auth with email>----------------------------------
class SignInUserAuthLoadingState extends SignInStates {}

class SignInUserAuthSuccessState extends SignInStates {}

class SignInUserAuthErrorState extends SignInStates {}

//-------------------------------<User Auth with google>----------------------------------
class GoogleSignInLoadingState extends SignInStates {}

class GoogleSignInSuccessState extends SignInStates {}

class GoogleSignInErrorState extends SignInStates {}

//-------------------------------<User Auth with facebook>----------------------------------
class FacebookSignInLoadingState extends SignInStates {}

class FacebookSignInSuccessState extends SignInStates {}

class FacebookSignInErrorState extends SignInStates {}
