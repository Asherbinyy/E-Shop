import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  CacheHelper._();

  static late SharedPreferences _sharedPreferences ;

  /// Instantiate an instance from SharedPreferences
  static Future <SharedPreferences> init ()async{
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Used to Save data in device's cached Memory

  static Future <bool> saveData (String key ,dynamic value){
    if (value is String) return _sharedPreferences.setString(key, value);
    if (value is bool) return _sharedPreferences.setBool(key, value);
    if (value is int) return _sharedPreferences.setInt(key, value);
    if (value is double) return _sharedPreferences.setDouble(key, value);
    if (value is List<String>) return _sharedPreferences.setStringList(key, value);
    else return _sharedPreferences.setStringList(key, value);
  }
  /// Used to get data from cache if saved before
  static dynamic  getData (String key){
    if (_sharedPreferences.containsKey(key)){
      return _sharedPreferences.get(key);
    }
  }
  /// If true value of the given key is deleted from cache
  static Future <bool> removeData (String key){
    return _sharedPreferences.remove(key);
  }
  /// If true all data cached is deleted
  static Future <bool> clear (String key){
    return _sharedPreferences.clear();
  }


}
