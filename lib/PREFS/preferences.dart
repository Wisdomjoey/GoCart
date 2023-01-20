import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  saveListData(String key, List<String> value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setStringList(key, value);
  }

  Future<List<String>?> getListData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String>? list = sharedPreferences.getStringList(key);
    
    return list;
  }

  saveStringData(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(key, value);
  }

  getStringData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(key);
  }

  saveIntData(String key, int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setInt(key, value);
  }

  saveBoolData(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool(key, value);
  }

  getBoolData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(key);
  }

  saveDoubleData(String key, double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble(key, value);
  }

  getDoubleData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getDouble(key);
  }
}
