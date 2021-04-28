import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";

  static Future<bool> loginAdministrator(String username, String password) async {
    var uri = Uri.http(apiUrl, 'api/administrator/login', {
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

  static getAllPoliklinik() async {
    var uri = Uri.http(apiUrl, 'poliklinik');
    var result = await http.get(uri);
    if(result.statusCode == 200){
      return json.decode(result.body);
    } else {
      return null;
    }
    /*
    var uri = Uri.http(apiUrl, 'poliklinik');
    var result = await http.get(uri);
    if(result.statusCode == 200){
      var daftarPoli = json.decode(result.body) as List;
      List<Poliklinik> Objs = daftarPoli.map((aJson) => Poliklinik.fromJson(aJson)).toList();
      return Objs;
    } else {
      return null;
    }
    */

  }
}