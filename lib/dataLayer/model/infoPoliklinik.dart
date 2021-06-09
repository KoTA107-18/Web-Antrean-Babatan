class InfoPoliklinik {
  int totalAntrean;
  int antreanSementara;
  int nomorAntrean;
  int idPoli;
  int statusPoli;
  String namaPoli;

  InfoPoliklinik(
      {this.totalAntrean,
        this.antreanSementara,
        this.nomorAntrean,
        this.idPoli,
        this.statusPoli,
        this.namaPoli});

  InfoPoliklinik.fromJson(Map<String, dynamic> json) {
    totalAntrean = json['total_antrean'];
    antreanSementara = json['antrean_sementara'];
    nomorAntrean = json['nomor_antrean'];
    idPoli = json['id_poli'];
    statusPoli = json['status_poli'];
    namaPoli = json['nama_poli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_antrean'] = this.totalAntrean;
    data['antrean_sementara'] = this.antreanSementara;
    data['nomor_antrean'] = this.nomorAntrean;
    data['id_poli'] = this.idPoli;
    data['status_poli'] = this.statusPoli;
    data['nama_poli'] = this.namaPoli;
    return data;
  }
}