import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future<bool> saveDataAtSharedPref(
      {required String key, required dynamic value}) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    return await sharedPreferences!.setInt(key, value);
  }

  static Object? getDataFromSharedPref({required dynamic key}) =>
      sharedPreferences!.get(key);

  static Future<bool> removeData({required String? key}) async =>
      await sharedPreferences!.remove(key!);
}
