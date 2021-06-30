import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_antrean_babatan/dataLayer/model/infoPoliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';
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

  static Future validasiPasien(Pasien pasien) async {
    var uri = Uri.http(apiUrl, 'pasien/validasi');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pasien.toJson()));
    return json.decode(result.body);
  }

  static Future<bool> loginAdministrator(
      String username, String password) async {
    var uri = Uri.https(apiUrl, 'administrator/login',
        {"username": username, "password": password});
    var result = await http.post(uri);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /*
    Method for functional Jadwal Pasien.
  */

  static Future getAntreanUtama(String idPoli) async {
    var uri = Uri.https(apiUrl, 'antrean/poliklinik/utama/$idPoli');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getAntreanSementara(String idPoli) async {
    var uri = Uri.https(apiUrl, 'antrean/poliklinik/sementara/$idPoli');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getAntreanSelesai(String idPoli) async {
    var uri = Uri.https(apiUrl, 'antrean/poliklinik/selesai/$idPoli');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getAntreanRiwayat(String idPoli) async {
    var uri = Uri.https(apiUrl, 'antrean/poliklinik/riwayat/$idPoli');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> editAntrean(JadwalPasien data) async {
    var uri = Uri.https(apiUrl, 'antrean');
    var result = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /*
    Method for functional Poliklinik.
  */

  static Future getInfoPoliklinik() async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean/info
    Method Type : GET
    Desc : Get All Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'antrean/info');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getAllPoliklinik() async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik
    Method Type : GET
    Desc : Get All Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'poliklinik');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getPoliklinik(int id) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik
    Method Type : GET
    Desc : Get Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'poliklinik/${id.toString()}');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future insertPoliklinik(Poliklinik dataPoliklinik) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik
    Method Type : POST
    Desc : Insert Data Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'poliklinik');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataPoliklinik.toJson()));
    if (result.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  static Future<bool> updatePoliklinik(
      Poliklinik dataPoliklinik) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik/id
    Method Type : PUT
    Desc : Update Data Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'poliklinik/${dataPoliklinik.idPoli}');
    var result = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataPoliklinik.toJson()));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateStatus(List<InfoPoliklinik> daftarPoliklinik) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik/status
    Method Type : PUT
    Desc : Update Portal Poliklinik in Database
    */
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


  /*
    Method for functional Perawat.
  */

  static Future getAllPerawat() async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : GET
    Desc : Get All Perawat in Database
    */
    var uri = Uri.https(apiUrl, 'perawat');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getPerawat(String id) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : GET
    Desc : Get Perawat in Database
    */
    var uri = Uri.https(apiUrl, 'perawat/$id');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> editPerawat(Perawat perawat) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat/id
    Method Type : PUT
    Desc : Edit Account Perawat
    */
    var uri = Uri.https(apiUrl, 'perawat/${perawat.idPerawat}');
    var result = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(perawat.toJson()));
    print(result.body);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addPerawat(Perawat perawat) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : POST
    Desc : Insert New Account Perawat
    */
    var uri = Uri.https(apiUrl, 'perawat');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(perawat.toJson()));
    print(result.body);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletePerawat(int idPerawat) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : DELETE
    Desc : Delete Account Perawat
    */
    var uri = Uri.https(apiUrl, 'perawat/${idPerawat.toString()}');
    var result = await http.delete(uri);
    print(result.body);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future loginPerawat(
      String username, String password) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat/login
    Method Type : POST
    Desc : Check Account Perawat
    */
    var uri = Uri.https(apiUrl, 'perawat/login',
        {"username": username, "password": password});
    var result = await http.post(uri);
    print(username);
    print(password);
    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    } else {
      return null;
    }
  }
}