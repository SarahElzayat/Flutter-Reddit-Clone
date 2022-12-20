/// @author Sarah Elzayat
/// @date 3/11/2022
/// @description This control the cache of the app

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// This method is used to save data in the cache.
  static Future<dynamic> putData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  /// This method is used to get data from the cache.
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  /// This method is used to remove data from the cache.
  static dynamic removeData({required key}) {
    return sharedPreferences.remove(key);
  }
}
