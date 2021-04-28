class Poliklinik {
  int id_poli;
  String nama_poli;
  String desc_poli;
  int status_poli;
  int rerata_waktu_pelayanan;
  Poliklinik(
      {this.id_poli,
      this.nama_poli,
      this.desc_poli,
      this.status_poli,
      this.rerata_waktu_pelayanan});

  factory Poliklinik.fromJson(Map<String, dynamic> map) {
    return Poliklinik(
        id_poli: map["id_poli"],
        nama_poli: map["nama_poli"],
        desc_poli: map["desc_poli"],
        status_poli: map["status_poli"],
        rerata_waktu_pelayanan: map["rerata_waktu_pelayanan"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_poli": id_poli,
      "nama_poli": nama_poli,
      "desc_poli": desc_poli,
      "status_poli": status_poli,
      "rerata_waktu_pelayanan": rerata_waktu_pelayanan
    };
  }
}
