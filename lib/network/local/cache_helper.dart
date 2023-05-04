import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  Future<bool?> setData({required String key , required bool value}) async
  {
    return await sharedPreferences?.setBool(key, value);
  }
  bool? getData({required String key})
  {
    return sharedPreferences?.getBool(key);
  }
}