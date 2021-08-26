import 'package:shared_preferences/shared_preferences.dart';

class SharedTokenUtil {
  static void saveToken(String token, String tokenTitle) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(tokenTitle, token);
  }

  static Future<String?> getToken(String tokenTitle) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString(tokenTitle);
    return token;
  }

  static void saveBool(bool value, String valueString)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(valueString, value);
  }

  static Future<bool?> getBool(String valueString) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool? value = _prefs.getBool(valueString);
    return value;
  }

  static void remove(String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(value);
  }
}