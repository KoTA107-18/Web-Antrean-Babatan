import 'dart:convert';

import 'package:web_antrean_babatan/dataLayer/model/jadwal.dart';

List<Poliklinik> poliklinikFromJson(String str) => List<Poliklinik>.from(json.decode(str).map((x) => Poliklinik.fromJson(x)));

String poliklinikToJson(List<Poliklinik> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Poliklinik {
  Poliklinik({
    this.idPoli,
    this.namaPoli,
    this.descPoli,
    this.statusPoli,
    this.rerataWaktuPelayanan,
    this.batasBooking,
    this.jadwal,
  });

  int idPoli;
  String namaPoli;
  String descPoli;
  String statusPoli;
  String rerataWaktuPelayanan;
  String batasBooking;
  List<Jadwal> jadwal;

  factory Poliklinik.fromJson(Map<String, dynamic> json) => Poliklinik(
    idPoli: json["id_poli"],
    namaPoli: json["nama_poli"],
    descPoli: json["desc_poli"],
    statusPoli: json["status_poli"],
    rerataWaktuPelayanan: json["rerata_waktu_pelayanan"],
    batasBooking: json["batas_booking"],
    jadwal: List<Jadwal>.from(json["jadwal"].map((x) => Jadwal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_poli": idPoli,
    "nama_poli": namaPoli,
    "desc_poli": descPoli,
    "status_poli": statusPoli,
    "rerata_waktu_pelayanan": rerataWaktuPelayanan,
    "batas_booking": batasBooking,
    "jadwal": List<dynamic>.from(jadwal.map((x) => x.toJson())),
  };

  String jadwalToString(){
    String daftarHari = "";
    for (var i=0; i<jadwal.length; i++) {
      if(i+1 == jadwal.length){
        daftarHari += jadwal[i].hari + ".";
      } else {
        daftarHari += jadwal[i].hari + ", ";
      }
    }

    if(daftarHari==""){
      daftarHari = "-";
    }
    return daftarHari;
  }
}