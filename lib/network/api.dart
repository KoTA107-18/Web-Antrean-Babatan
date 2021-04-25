import 'package:http/http.dart' as http;

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";

  static Future<bool> loginAdministrator(String username, String password) async {
    var uri = Uri.http(apiUrl, 'administrator/login', {
      "username" : username,
      "password" : password
    });
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}