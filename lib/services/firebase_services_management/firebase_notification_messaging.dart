import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:todoey/components/toast/toast_helper.dart';
import 'package:todoey/services/sharedpreferences/sharedpreferences_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class FirebaseNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> notification() async {
    messaging.getToken().then((value) async {
      SharedPreferencesHelper.saveDataAtSharedPref(
          key: 'deviceId', value: value);
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showToast(message: 'It\'s Task Time: ${message.notification!.title.toString()} !');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showToast(message: 'It\'s Task Time: ${event.notification!.title.toString()} !');
    });
  }
}
