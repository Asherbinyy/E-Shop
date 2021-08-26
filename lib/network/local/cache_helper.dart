import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static late SharedPreferences _sharedPreferences ;

  static Future <SharedPreferences> init ()async{
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future <bool> saveData (String key ,dynamic value){
    if (value is String) return _sharedPreferences.setString(key, value);
    if (value is bool) return _sharedPreferences.setBool(key, value);
    if (value is int) return _sharedPreferences.setInt(key, value);
    if (value is double) return _sharedPreferences.setDouble(key, value);
    else return _sharedPreferences.setStringList(key, value);
  }

  static dynamic  getData (String key){
    return _sharedPreferences.get(key);
  }

  static Future <bool> removeData (String key){
    return _sharedPreferences.remove(key);
  }


}
