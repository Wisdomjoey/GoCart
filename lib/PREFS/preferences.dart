import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  saveListData(String key, List<String> value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.setStringList(key, value);
  }

  saveStringData(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.setString(key, value);
  }
}
