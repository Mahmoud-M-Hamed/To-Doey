import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/layouts/splash_screen/splash_screen_activity.dart';
import 'package:todoey/layouts/todoey_home/todoey_home_activity.dart';
import 'package:todoey/services/firebase_services_management/firebase_notification_messaging.dart';
import 'package:todoey/services/http_services_management/http_services.dart';
import 'package:todoey/services/sharedpreferences/sharedpreferences_service.dart';
import 'package:todoey/styles/theme.dart';
import 'package:workmanager/workmanager.dart';
import 'services/background_services_management/background_services.dart';
import 'services/statemanagement/bloc_observer.dart';

void main() async {
  Widget navigatePage;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await HttpHelper.init();
  await SharedPreferencesHelper.init();
  token = SharedPreferencesHelper.getDataFromSharedPref(key: 'token');
  checkboxValue =
      SharedPreferencesHelper.getDataFromSharedPref(key: 'checkboxState');

  FirebaseNotification firebaseNotification = FirebaseNotification();
  await firebaseNotification.notification();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  Bloc.observer = MyBlocObserver();

  (token != null && checkboxValue != null)
      ? navigatePage = const TodoeyHomeActivity()
      : navigatePage = const SplashScreen();

  runApp(MyApp(
    startPage: navigatePage,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget? startPage;

  MyApp({this.startPage, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppMainName,
      home: startPage,
      theme: themeData,
    );
  }
}
