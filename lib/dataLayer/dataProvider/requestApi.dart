import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";

  static Future<bool> registerPasien(Pasien pasien) async {
    var result = await http.post(Uri.http(apiUrl, 'api/pasien/register'),
        body: pasien.toJson());
    if (result.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> loginAdministrator(
      String username, String password) async {
    var uri = Uri.https(apiUrl, 'administrator/login',
        {"username": username, "password": password});
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future getAllPoliklinik() async {
    var uri = Uri.https(apiUrl, 'poliklinik');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future insertPoliklinik(Map<String, dynamic> dataPoliklinik) async {
    var uri = Uri.https(apiUrl, 'poliklinik');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataPoliklinik));
    if (result.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  static Future<bool> updatePoliklinik(
      Map<String, dynamic> dataPoliklinik) async {
    var uri = Uri.https(apiUrl, 'poliklinik/ubah');
    var result = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataPoliklinik));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateStatus(List<Poliklinik> daftarPoliklinik) async {
    var uri = Uri.https(apiUrl, 'poliklinik/status');
    List data = [];
    for (var i in daftarPoliklinik) {
      data.add({"id_poli": i.idPoli, "status_poli": i.statusPoli});
    }
    var result = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
