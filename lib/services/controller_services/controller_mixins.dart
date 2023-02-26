import 'package:flutter/material.dart';

mixin Controllers {
  final formKey = GlobalKey<FormState>();
  final alertFormKey = GlobalKey<FormState>();
  final tasksFormKey = GlobalKey<FormState>();

  // ---------------------<Controllers>-----------------------------------------

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addTaskController = TextEditingController();
  final TextEditingController taskTimeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
}
