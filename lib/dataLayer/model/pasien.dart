class Pasien {
  String username;
  String noHandphone;
  String kepalaKeluarga;
  String namaLengkap;
  String password;
  String alamat;
  String tglLahir;
  Pasien(
      {this.username,
      this.noHandphone,
      this.kepalaKeluarga,
      this.namaLengkap,
      this.password,
      this.alamat,
      this.tglLahir});
  factory Pasien.fromJson(Map<String, dynamic> map) {
    return Pasien(
        username: map["username"],
        noHandphone: map["no_handphone"],
        kepalaKeluarga: map["kepala_keluarga"],
        namaLengkap: map["nama_lengkap"],
        password: map["password"],
        alamat: map["alamat"],
        tglLahir: map["tgl_lahir"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "no_handphone": noHandphone,
      "kepala_keluarga": kepalaKeluarga,
      "nama_lengkap": namaLengkap,
      "password": password,
      "alamat": alamat,
      "tgl_lahir": tglLahir
    };
  }
}
