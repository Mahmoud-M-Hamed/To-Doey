import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todoey/components/alertdialog/showalertdialog.dart';
import 'package:todoey/components/animation/spin_kit.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/layouts/unity/sign_up/signup_activity.dart';
import 'package:todoey/services/sharedpreferences/sharedpreferences_service.dart';
import 'package:todoey/styles/icons/broken_icons.dart';
import '../../../components/reusablecomponents/reusable_components.dart';
import '../../../services/controller_services/controller_mixins.dart';
import '../../../services/facebook_services_management/facebook_management.dart';
import '../../../services/firebase_services_management/firebase_services.dart';
import '../../../services/google_services_management/google_management.dart';
import '../../../services/statemanagement/unity_state_management/shared_unity_management/shared_unity_cubit.dart';
import '../../../services/statemanagement/unity_state_management/shared_unity_management/shared_unity_state.dart';
import '../../../services/statemanagement/unity_state_management/signin_management/sign_in_cubit.dart';
import '../../../services/statemanagement/unity_state_management/signin_management/sign_in_state.dart';
import '../../todoey_home/todoey_home_activity.dart';

class SignInActivity extends StatelessWidget
    with
        GoogleServices,
        FacebookServices,
        FirebaseServices,
        Controllers,
        DoubleBouncingAnimation {
  SignInActivity({super.key});

  Widget facebookOrGoogleIconButtons(
          {required String assetImagePath, required VoidCallback onTap}) =>
      InkWell(
        onTap: onTap,
        child: CircleAvatar(
          backgroundImage: AssetImage(
            assetImagePath,
          ),
          radius: 25,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SharedUnityCubit()..getUnityImagesFromFireBase,
        ),
        BlocProvider(
          create: (context) => SignInCubit(),
        ),
      ],
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SignInCubit signInCubit = SignInCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: BlocConsumer<SharedUnityCubit, SharedUnityStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  SharedUnityCubit sharedUnityCubit =
                      SharedUnityCubit.get(context);
                  Object? checkbox =
                      SharedPreferencesHelper.getDataFromSharedPref(
                          key: 'checkboxState');

                  Widget content() => Form(
                        key: alertFormKey,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'phone Number',
                          ),
                          validator: (validation) => sharedUnityCubit
                              .phoneNumberValidation(validation: validation!),
                        ),
                      );

                  List<Widget> actions() => <Widget>[
                        IconButton(
                            onPressed: () {
                              if (alertFormKey.currentState!.validate()) {
                                updateDataInFirebase(
                                    collectionPath: 'usersInfo',
                                    docId: firebaseAuth.currentUser!.uid,
                                    map: {
                                      'phoneNumber': phoneNumberController.text,
                                    }).whenComplete(() {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TodoeyHomeActivity(),
                                    ),
                                  );
                                });
                              }
                            },
                            icon: const Icon(
                              BrokenIcons.send,
                              size: 25,
                              color: kAppMainColor,
                            )),
                      ];

                  Future<void> onTapFacebookIcon() async {
                    sharedUnityCubit.isSavingModalProgressHud = true;
                    await signInCubit
                        .userAuthenticationWithFacebook()
                        .whenComplete(() {
                      sharedUnityCubit.isSavingModalProgressHud = false;
                      if (state is! FacebookSignInErrorState) {
                        showAlertDialog(
                          context: context,
                          barrierDismissible: false,
                          actions: actions(),
                          title: 'Please Enter Phone Number For Verification !',
                          content: content(),
                        );
                      }
                      if (signInCubit.checkboxState &&
                          firebaseAuth.currentUser!.uid.isNotEmpty) {
                        SharedPreferencesHelper.saveDataAtSharedPref(
                          key: 'token',
                          value: firebaseAuth.currentUser!.uid,
                        );
                      }
                    });
                  }

                  Future<void> onTapGoogleIcon() async {
                    sharedUnityCubit.isSavingModalProgressHud = true;
                    await signInCubit
                        .userAuthenticationWithGoogle()
                        .whenComplete(() {
                      sharedUnityCubit.isSavingModalProgressHud = false;
                      showAlertDialog(
                          context: context,
                          barrierDismissible: false,
                          actions: actions(),
                          title: 'Please Enter Phone Number For Verification !',
                          content: content());
                      if (signInCubit.checkboxState &&
                          firebaseAuth.currentUser!.uid.isNotEmpty) {
                        SharedPreferencesHelper.saveDataAtSharedPref(
                          key: 'token',
                          value: firebaseAuth.currentUser!.uid,
                        );
                      }
                    });
                  }

                  return ModalProgressHUD(
                    inAsyncCall: sharedUnityCubit.isSaving,
                    blur: 1.2,
                    progressIndicator: super.doubleBouncingSpinner(),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              (state is GetLocalImagesLoadingState ||
                                      sharedUnityCubit.unityLocalImagesModel
                                              .signInImage ==
                                          null)
                                  ? SizedBox(
                                      height: 240,
                                      child: super.doubleBouncingSpinner(),
                                    )
                                  : Image(
                                      image: NetworkImage(
                                        sharedUnityCubit
                                            .unityLocalImagesModel.signInImage
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                      height: 240,
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: rTextField(
                                  textEditingController: emailController,
                                  labelText: 'Email Address',
                                  prefixIcon: BrokenIcons.message,
                                  validator: (validation) =>
                                      sharedUnityCubit.emailValidationFunction(
                                          validation: validation!),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: rTextField(
                                  textEditingController: passwordController,
                                  labelText: 'Password',
                                  prefixIcon: BrokenIcons.lock,
                                  suffixIcon: sharedUnityCubit.hideEyePassword,
                                  obscureText: sharedUnityCubit.isPasswordShown,
                                  onPressedIconSuffix: () => sharedUnityCubit
                                      .toggleHideEyePasswordIconState(),
                                  validator: (validation) => sharedUnityCubit
                                      .passwordValidationFunction(
                                          validation: validation!),
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: (checkbox != null)
                                          ? checkbox as bool
                                          : signInCubit.checkboxState,
                                      onChanged: (checkboxState) {
                                        signInCubit.toggleCheckboxState(
                                            checkboxState: checkboxState!);
                                      }),
                                  const Text(
                                    'Remember me !',
                                    style: TextStyle(
                                      color: kAppMainColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              rMaterialButton(
                                color: kAppMainColor,
                                splashColor: Colors.blue,
                                horizontal: 40,
                                vertical: 10,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    sharedUnityCubit.isSavingModalProgressHud =
                                        true;
                                    signInCubit.userAuthentication(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    Future.delayed(const Duration(seconds: 6),
                                        () {
                                      sharedUnityCubit
                                          .isSavingModalProgressHud = false;
                                      if (firebaseAuth
                                              .currentUser!.uid.isNotEmpty &&
                                          State is SignInUserAuthSuccessState) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TodoeyHomeActivity()));
                                      }
                                      if (signInCubit.checkboxState &&
                                          firebaseAuth
                                              .currentUser!.uid.isNotEmpty) {
                                        SharedPreferencesHelper
                                            .saveDataAtSharedPref(
                                          key: 'token',
                                          value: firebaseAuth.currentUser!.uid,
                                        );
                                      }
                                    });
                                  }
                                },
                                child: const Text(
                                  'sign In',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    facebookOrGoogleIconButtons(
                                      assetImagePath:
                                          'assets/images/facebook.png',
                                      onTap: onTapFacebookIcon,
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    facebookOrGoogleIconButtons(
                                      assetImagePath:
                                          'assets/images/google.png',
                                      onTap: onTapGoogleIcon,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don\'t have an account ?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpActivity()));
                                      },
                                      child: const Text(
                                        'SignUp',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
