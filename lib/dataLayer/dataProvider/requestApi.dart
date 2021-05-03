import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";

  static Future<bool> loginAdministrator(
      String username, String password) async {
    var uri = Uri.http(apiUrl, 'administrator/login',
        {"username": username, "password": password});
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future getAllPoliklinik() async {
    var uri = Uri.http(apiUrl, 'poliklinik');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> updatePoliklinik(Poliklinik poliklinik) async {
    var uri = Uri.http(apiUrl, 'poliklinik/ubah');
    var result = await http.put(uri, body: poliklinik.toJson());
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateStatus(List<Poliklinik> daftarPoliklinik) async {
    var uri = Uri.http(apiUrl, 'poliklinik/status');
    List data = [];
    for (var i in daftarPoliklinik) {
      data.add({
        'id_poli': i.idPoli.toString(),
        'status_poli': i.statusPoli.toString()
      });
    }
    var result = await http.put(uri, body: data);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
