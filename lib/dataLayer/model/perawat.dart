class Perawat {
  int idPerawat;
  String username;
  String password;
  String nama;
  int idPoli;
  String namaPoli;

  Perawat(
      {this.idPerawat,
        this.username,
        this.password,
        this.nama,
        this.idPoli,
        this.namaPoli});

  Perawat.fromJson(Map<String, dynamic> json) {
    idPerawat = json['id_perawat'];
    username = json['username'];
    password = json['password'];
    nama = json['nama'];
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_perawat'] = this.idPerawat;
    data['username'] = this.username;
    data['password'] = this.password;
    data['nama'] = this.nama;
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    return data;
  }
}