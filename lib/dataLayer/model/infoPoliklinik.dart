import 'dart:convert';

List<InfoPoliklinik> infoPoliklinikFromJson(String str) => List<InfoPoliklinik>.from(json.decode(str).map((x) => InfoPoliklinik.fromJson(x)));

String infoPoliklinikToJson(List<InfoPoliklinik> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoPoliklinik {
  InfoPoliklinik({
    this.idPoli,
    this.namaPoli,
    this.statusPoli,
    this.totalAntrean,
    this.antreanSementara,
    this.nomorAntrean,
  });

  int idPoli;
  String namaPoli;
  String statusPoli;
  List<dynamic> totalAntrean;
  List<dynamic> antreanSementara;
  List<dynamic> nomorAntrean;

  factory InfoPoliklinik.fromJson(Map<String, dynamic> json) => InfoPoliklinik(
    idPoli: json["id_poli"],
    namaPoli: json["nama_poli"],
    statusPoli: json["status_poli"],
    totalAntrean: List<dynamic>.from(json["total_antrean"].map((x) => x)),
    antreanSementara: List<dynamic>.from(json["antrean_sementara"].map((x) => x)),
    nomorAntrean: List<dynamic>.from(json["nomor_antrean"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id_poli": idPoli,
    "nama_poli": namaPoli,
    "status_poli": statusPoli,
    "total_antrean": List<dynamic>.from(totalAntrean.map((x) => x)),
    "antrean_sementara": List<dynamic>.from(antreanSementara.map((x) => x)),
    "nomor_antrean": List<dynamic>.from(nomorAntrean.map((x) => x)),
  };
}
