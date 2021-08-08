import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_antrean_babatan/dataLayer/model/infoPoliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

class RequestApi {
  static final String apiUrl = "apibabatan.kota107.xyz";

  static Future<bool> registerPasien(Pasien pasien) async {
    var result = await http.post(
      Uri.https(apiUrl, 'api/pasien/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pasien.toJson()),
    );
    if (result.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future validasiPasien(Pasien pasien) async {
    var uri = Uri.https(apiUrl, 'api/pasien/validasi');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pasien.toJson()));
    return json.decode(result.body);
  }

  static Future<bool> loginAdministrator(
      String username, String password) async {
    var uri = Uri.https(apiUrl, 'api/administrator/login',
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

  static Future getAntreanUtama(String idPoli, String apiToken) async {
    var uri = Uri.https(apiUrl, 'api/antrean/poliklinik/utama/$idPoli');
    var result = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer $apiToken',
    });
    print(result.body);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getAntreanSementara(String idPoli, String apiToken) async {
    var uri = Uri.https(apiUrl, 'api/antrean/poliklinik/sementara/$idPoli');
    var result = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer $apiToken',
    });
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

  static Future getAntreanRiwayat(String idPoli, String apiToken) async {
    var uri = Uri.https(apiUrl, 'api/antrean/poliklinik/riwayat/$idPoli');
    var result = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer $apiToken',
    });
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> editAntrean(JadwalPasien data, String apiToken) async {
    var uri = Uri.https(apiUrl, 'api/antrean/edit');
    var result = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer $apiToken',
        },
        body: jsonEncode(data.toJson()));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future insertAntreanNormal(
      Map<String, dynamic> data, String apiToken) async {
    var uri = Uri.https(apiUrl, 'api/antrean/insert/admin');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer $apiToken',
        },
        body: jsonEncode(data));
    print(result.body.toString());
    if (result.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  static Future insertAntreanGawat(
      Map<String, dynamic> data, String apiToken) async {
    var uri = Uri.https(apiUrl, 'api/antrean/insert/admin/gawat');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer $apiToken',
        },
        body: jsonEncode(data));
    print(data);
    print(result.body);
    if (result.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  /*
    Method for functional Poliklinik.
  */

  static Future getInfoPoliklinik(String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean/info
    Method Type : GET
    Desc : Get All Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'api/antrean/info');
    var result = await http.get(uri, headers: {
      'Authorization': 'bearer $apiToken',
    });
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getAllPoliklinik(String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik
    Method Type : GET
    Desc : Get All Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'api/poliklinik');
    var result = await http.get(uri, headers: {
      'Authorization': 'bearer $apiToken',
    });
    print(result.body);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getPoliklinik(int id, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik
    Method Type : GET
    Desc : Get Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'api/poliklinik/${id.toString()}');
    var result = await http.get(uri, headers: {
      'Authorization': 'bearer $apiToken',
    });
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future insertPoliklinik(
      Poliklinik dataPoliklinik, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik
    Method Type : POST
    Desc : Insert Data Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'api/poliklinik/insert');
    var result = await http.post(uri,
        headers: {
          'Authorization': 'bearer $apiToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataPoliklinik.toJson()));
    print(result.body);
    if (result.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  static Future<bool> updatePoliklinik(
      Poliklinik dataPoliklinik, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik/id
    Method Type : PUT
    Desc : Update Data Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'api/poliklinik/edit/${dataPoliklinik.idPoli}');
    var result = await http.put(uri,
        headers: {
          'Authorization': 'bearer $apiToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dataPoliklinik.toJson()));
    print(result.body.toString());
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateStatus(
      List<InfoPoliklinik> daftarPoliklinik, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik/status
    Method Type : PUT
    Desc : Update Portal Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'api/poliklinik/status');
    List data = [];
    for (var i in daftarPoliklinik) {
      data.add({"id_poli": i.idPoli, "status_poli": i.statusPoli});
    }
    print(data);
    var result = await http.put(uri,
        headers: {
          'Authorization': 'bearer $apiToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    print(result.statusCode);
    print(result.body);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /*
    Method for functional Perawat.
  */

  static Future getAllPerawat(String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : GET
    Desc : Get All Perawat in Database
    */
    var uri = Uri.https(apiUrl, 'api/perawat');
    var result = await http.get(uri, headers: {
      'Authorization': 'bearer $apiToken',
    });
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getPerawat(String id, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : GET
    Desc : Get Perawat in Database
    */
    var uri = Uri.https(apiUrl, 'api/perawat/$id');
    var result = await http.get(uri, headers: {
      'Authorization': 'bearer $apiToken',
    });
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> editPerawat(Perawat perawat, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat/id
    Method Type : PUT
    Desc : Edit Account Perawat
    */
    var uri = Uri.https(apiUrl, 'api/perawat/edit/${perawat.idPerawat}');
    var result = await http.put(uri,
        headers: {
          'Authorization': 'bearer $apiToken',
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

  static Future<bool> addPerawat(Perawat perawat, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : POST
    Desc : Insert New Account Perawat
    */
    var uri = Uri.https(apiUrl, 'api/perawat/insert');
    var result = await http.post(uri,
        headers: {
          'Authorization': 'bearer $apiToken',
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

  static Future<bool> deletePerawat(int idPerawat, String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat
    Method Type : DELETE
    Desc : Delete Account Perawat
    */
    var uri = Uri.https(apiUrl, 'api/perawat/delete/${idPerawat.toString()}');
    var result = await http.delete(uri, headers: {
      'Authorization': 'bearer $apiToken',
    });
    print(result.body);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future loginPerawat(String username, String password) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/perawat/login
    Method Type : POST
    Desc : Check Account Perawat
    */
    var uri = Uri.https(apiUrl, 'api/perawat/login',
        {"username": username, "password": password});
    var result = await http.post(uri);
    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    } else {
      return null;
    }
  }
}
