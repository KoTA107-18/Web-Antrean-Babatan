import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String _username = "KEY_USERNAME";

  static Future<void> saveLogin(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_username, username);
  }

  static Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(_username);
    if(username != null){
      return true;
    } else {
      return false;
    }
  }

  static Future<void> deleteSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
