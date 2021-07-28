// To parse this JSON data, do
//
//     final responseGetPerawat = responseGetPerawatFromJson(jsonString);

import 'dart:convert';

List<ResponseGetPerawat> responseGetPerawatFromJson(String str) => List<ResponseGetPerawat>.from(json.decode(str).map((x) => ResponseGetPerawat.fromJson(x)));

String responseGetPerawatToJson(List<ResponseGetPerawat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseGetPerawat {
  ResponseGetPerawat({
    this.idPerawat,
    this.username,
    this.password,
    this.nama,
    this.idPoli,
    this.poliklinik,
  });

  String idPerawat;
  String username;
  String password;
  String nama;
  String idPoli;
  PoliklinikPerawat poliklinik;

  factory ResponseGetPerawat.fromJson(Map<String, dynamic> json) => ResponseGetPerawat(
    idPerawat: json["id_perawat"],
    username: json["username"],
    password: json["password"],
    nama: json["nama"],
    idPoli: json["id_poli"],
    poliklinik: PoliklinikPerawat.fromJson(json["poliklinik"]),
  );

  Map<String, dynamic> toJson() => {
    "id_perawat": idPerawat,
    "username": username,
    "password": password,
    "nama": nama,
    "id_poli": idPoli,
    "poliklinik": poliklinik.toJson(),
  };
}

class PoliklinikPerawat {
  PoliklinikPerawat({
    this.idPoli,
    this.namaPoli,
  });

  int idPoli;
  String namaPoli;

  factory PoliklinikPerawat.fromJson(Map<String, dynamic> json) => PoliklinikPerawat(
    idPoli: json["id_poli"],
    namaPoli: json["nama_poli"],
  );

  Map<String, dynamic> toJson() => {
    "id_poli": idPoli,
    "nama_poli": namaPoli,
  };
}
