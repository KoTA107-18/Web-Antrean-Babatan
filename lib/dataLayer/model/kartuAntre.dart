class KartuAntre {
  int idJadwalPasien;
  int idHari;
  int idPoli;
  String username;
  int nomorAntrean;
  int tipeBooking;
  String tglPelayanan;
  String jamDaftarAntrean;
  String jamMulaiDilayani;
  String jamSelesaiDilayani;
  int statusAntrean;

  KartuAntre(
      {this.idJadwalPasien,
      this.idHari,
      this.idPoli,
      this.username,
      this.nomorAntrean,
      this.tipeBooking,
      this.tglPelayanan,
      this.jamDaftarAntrean,
      this.jamMulaiDilayani,
      this.jamSelesaiDilayani,
      this.statusAntrean});

  factory KartuAntre.fromJson(Map<String, dynamic> map) {
    return KartuAntre(
      idJadwalPasien: map["id_jadwal_pasien"],
      idHari: map["id_hari"],
      idPoli: map["id_poli"],
      username: map["username"],
      nomorAntrean: map["nomor_antrean"],
      tipeBooking: map["tipe_booking"],
      tglPelayanan: map["tgl_pelayanan"],
      jamDaftarAntrean: map["jam_daftar_antrean"],
      jamMulaiDilayani: map["jam_mulai_dilayani"],
      jamSelesaiDilayani: map["jam_selesai_dilayani"],
      statusAntrean: map["status_antrean"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_jadwal_pasien": idJadwalPasien.toString(),
      "id_hari": idHari.toString(),
      "id_poli": idPoli.toString(),
      "username": username.toString(),
      "nomor_antrean": nomorAntrean.toString(),
      "tipe_booking": tipeBooking.toString(),
      "tgl_pelayanan": tglPelayanan.toString(),
      "jam_daftar_antrean": jamDaftarAntrean.toString(),
      "jam_mulai_dilayani": jamMulaiDilayani.toString(),
      "jam_selesai_dilayani": jamSelesaiDilayani.toString(),
      "status_antrean": statusAntrean.toString(),
    };
  }
}
