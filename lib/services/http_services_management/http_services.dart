import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  static Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  static String cloudMessagingKey = 'key=AAAAOp1TjUE:'
      'APA91bGUhSAlrf_BVW22idPK94jNKYt-ex9F5n0lzB_07Grr8kdt8ZDMMUJPCVxIQOFF62lSAey4-ue5uxUOK'
      'ExB3B4BUpj90VCSaTXj9M4CX0W1ziaAEUPnumqkUJ35_lSRteWwbK1U';

  static init() async {
    await http.head(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': cloudMessagingKey
    });
  }

  static Future<void> httpPostData(
          {required Map<String, dynamic> responseMapBody}) async =>
      await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': cloudMessagingKey
          },
          body: jsonEncode(responseMapBody));
}
