class Poliklinik {
  int idPoli;
  String namaPoli;
  String descPoli;
  int statusPoli;
  int rerataWaktuPelayanan;

  Poliklinik(
      {this.idPoli,
        this.namaPoli,
        this.descPoli,
        this.statusPoli,
        this.rerataWaktuPelayanan});

  Poliklinik.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
    descPoli = json['desc_poli'];
    statusPoli = json['status_poli'];
    rerataWaktuPelayanan = json['rerata_waktu_pelayanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    data['desc_poli'] = this.descPoli;
    data['status_poli'] = this.statusPoli;
    data['rerata_waktu_pelayanan'] = this.rerataWaktuPelayanan;
    return data;
  }
}