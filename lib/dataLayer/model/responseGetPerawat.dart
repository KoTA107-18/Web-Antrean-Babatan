class ResponseGetPerawat {
  String idPerawat;
  String username;
  String password;
  String nama;
  String idPoli;
  PoliklinikPerawat poliklinik;

  ResponseGetPerawat(
      {this.idPerawat,
        this.username,
        this.password,
        this.nama,
        this.idPoli,
        this.poliklinik});

  ResponseGetPerawat.fromJson(Map<String, dynamic> json) {
    idPerawat = json['id_perawat'];
    username = json['username'];
    password = json['password'];
    nama = json['nama'];
    idPoli = json['id_poli'];
    poliklinik = json['poliklinik'] != null
        ? new PoliklinikPerawat.fromJson(json['poliklinik'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_perawat'] = this.idPerawat;
    data['username'] = this.username;
    data['password'] = this.password;
    data['nama'] = this.nama;
    data['id_poli'] = this.idPoli;
    if (this.poliklinik != null) {
      data['poliklinik'] = this.poliklinik.toJson();
    }
    return data;
  }
}

class PoliklinikPerawat {
  String idPoli;
  String namaPoli;

  PoliklinikPerawat({this.idPoli, this.namaPoli});

  PoliklinikPerawat.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    return data;
  }
}