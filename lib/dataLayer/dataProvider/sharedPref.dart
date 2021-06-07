import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String _username = "KEY_USERNAME";
  static String _poliklinik = "KEY_POLIKLINIK";
  static String _idPerawat = "KEY_ID_PERAWAT";
  static String _role = "KEY_ROLE";
  static String administrator = "ADMINISTRATOR";
  static String perawat = "PERAWAT";


  static Future<void> saveLogin(String username, int choiceRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_username, username);
    if(choiceRole == 0){
      prefs.setString(_role, administrator);
    } else {
      prefs.setString(_role, perawat);
    }
  }

  static Future<void> saveInfoPerawat(int idPoli, int idPerawat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_poliklinik, idPoli);
    prefs.setInt(_idPerawat, idPerawat);
  }

  static Future<int> getPoli() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int result = prefs.getInt(_poliklinik);
    return result;
  }

  static Future<int> getIdPerawat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int result = prefs.getInt(_idPerawat);
    return result;
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

  static Future<String> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString(_role);
    return result;
  }


  static Future<void> deleteSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
