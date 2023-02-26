import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todoey/components/animation/spin_kit.dart';
import 'package:todoey/components/reusablecomponents/reusable_components.dart';
import 'package:todoey/layouts/unity/sign_in/signin_activity.dart';
import 'package:todoey/styles/icons/broken_icons.dart';
import '../../../components/constants/constants.dart';
import '../../../services/controller_services/controller_mixins.dart';
import '../../../services/statemanagement/unity_state_management/shared_unity_management/shared_unity_cubit.dart';
import '../../../services/statemanagement/unity_state_management/shared_unity_management/shared_unity_state.dart';
import '../../../services/statemanagement/unity_state_management/signup_management/sign_up_cubit.dart';
import '../../../services/statemanagement/unity_state_management/signup_management/sign_up_state.dart';

class SignUpActivity extends StatelessWidget
    with Controllers, DoubleBouncingAnimation {
  SignUpActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SharedUnityCubit()..getUnityImagesFromFireBase,
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
      ],
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SignUpCubit signUpCubit = SignUpCubit.get(context);
          return Scaffold(
            body: BlocConsumer<SharedUnityCubit, SharedUnityStates>(
              listener: (context, state) {},
              builder: (context, state) {
                SharedUnityCubit sharedUnityCubit =
                    SharedUnityCubit.get(context);
                return SafeArea(
                  child: ModalProgressHUD(
                    inAsyncCall: sharedUnityCubit.isSaving,
                    progressIndicator: doubleBouncingSpinner(),
                    blur: 1.2,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              (state is GetLocalImagesLoadingState)
                                  ? SizedBox(
                                      height: 250,
                                      child: Center(
                                        child: super.doubleBouncingSpinner(),
                                      ),
                                    )
                                  : Image(
                                      image: NetworkImage(
                                        sharedUnityCubit
                                            .unityLocalImagesModel.signUpImage
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                      height: 250,
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              rTextField(
                                textEditingController: userNameController,
                                labelText: 'User Name',
                                prefixIcon: BrokenIcons.user_1,
                                validator: (validation) =>
                                    sharedUnityCubit.userNameValidationFunction(
                                        validation: validation!),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              rTextField(
                                textEditingController: emailController,
                                labelText: 'Email Address',
                                prefixIcon: BrokenIcons.message,
                                validator: (validation) =>
                                    sharedUnityCubit.emailValidationFunction(
                                        validation: validation!),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              rTextField(
                                textEditingController: phoneNumberController,
                                labelText: 'Phone Number',
                                prefixIcon: Icons.phone,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (validation) =>
                                    sharedUnityCubit.phoneNumberValidation(
                                        validation: validation!),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              rTextField(
                                textEditingController: passwordController,
                                labelText: 'Password',
                                prefixIcon: BrokenIcons.lock,
                                obscureText: sharedUnityCubit.isPasswordShown,
                                suffixIcon: sharedUnityCubit.hideEyePassword,
                                onPressedIconSuffix: () => sharedUnityCubit
                                    .toggleHideEyePasswordIconState(),
                                validator: (validation) =>
                                    sharedUnityCubit.passwordValidationFunction(
                                        validation: validation!),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              rTextField(
                                textEditingController:
                                    confirmPasswordController,
                                labelText: 'Confirm Password',
                                prefixIcon: BrokenIcons.lock,
                                obscureText: signUpCubit.isConfirmPasswordShown,
                                suffixIcon: signUpCubit.hideEyeConfirmPassword,
                                onPressedIconSuffix: () => signUpCubit
                                    .toggleHideEyeConfirmPasswordIconState(),
                                validator: (validation) {
                                  if (confirmPasswordController.text !=
                                          passwordController.text ||
                                      confirmPasswordController.text.isEmpty) {
                                    return 'Passwords not the same';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              rMaterialButton(
                                color: kAppMainColor,
                                splashColor: Colors.blue,
                                horizontal: 40,
                                vertical: 10,
                                child: const Text(
                                  'sign Up',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    sharedUnityCubit.isSavingModalProgressHud =
                                        true;
                                    await signUpCubit
                                        .createUserAuth(
                                      userName: userNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phoneNumber: phoneNumberController.text,
                                    )
                                        .whenComplete(
                                      () {
                                        Future.delayed(
                                          const Duration(seconds: 5),
                                          () {
                                            sharedUnityCubit
                                                    .isSavingModalProgressHud =
                                                false;
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SignInActivity(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
