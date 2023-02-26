import 'package:todoey/services/sharedpreferences/sharedpreferences_service.dart';
import 'package:workmanager/workmanager.dart';
import '../http_services_management/http_services.dart';

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    await SharedPreferencesHelper.init();
    dynamic deviceId =
        SharedPreferencesHelper.getDataFromSharedPref(key: 'deviceId');
    await HttpHelper.httpPostData(
      responseMapBody: {
        "to": '$deviceId',
        "notification": {
          "title": "${inputData!['title']}",
          "body": "${inputData['body']}",
          "sound": "default"
        },
      },
    );
    return Future.value(true);
  });
}
