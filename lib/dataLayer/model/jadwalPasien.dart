class JadwalPasien {
  int nomorAntrean;
  int tipeBooking;
  String tglPelayanan;
  String jamDaftarAntrean;
  String jamMulaiDilayani;
  String jamSelesaiDilayani;
  int statusAntrean;
  String hari;
  int idPoli;
  String namaPoli;
  int idPasien;
  String username;
  String noHandphone;
  String kepalaKeluarga;
  String namaLengkap;
  String alamat;
  String tglLahir;
  int jenisPasien;

  JadwalPasien(
      {this.nomorAntrean,
        this.tipeBooking,
        this.tglPelayanan,
        this.jamDaftarAntrean,
        this.jamMulaiDilayani,
        this.jamSelesaiDilayani,
        this.statusAntrean,
        this.hari,
        this.idPoli,
        this.namaPoli,
        this.idPasien,
        this.username,
        this.noHandphone,
        this.kepalaKeluarga,
        this.namaLengkap,
        this.alamat,
        this.tglLahir,
        this.jenisPasien});

  JadwalPasien.fromJson(Map<String, dynamic> json) {
    nomorAntrean = json['nomor_antrean'];
    tipeBooking = json['tipe_booking'];
    tglPelayanan = json['tgl_pelayanan'];
    jamDaftarAntrean = json['jam_daftar_antrean'];
    jamMulaiDilayani = json['jam_mulai_dilayani'];
    jamSelesaiDilayani = json['jam_selesai_dilayani'];
    statusAntrean = json['status_antrean'];
    hari = json['hari'];
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
    idPasien = json['id_pasien'];
    username = json['username'];
    noHandphone = json['no_handphone'];
    kepalaKeluarga = json['kepala_keluarga'];
    namaLengkap = json['nama_lengkap'];
    alamat = json['alamat'];
    tglLahir = json['tgl_lahir'];
    jenisPasien = json['jenis_pasien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomor_antrean'] = this.nomorAntrean;
    data['tipe_booking'] = this.tipeBooking;
    data['tgl_pelayanan'] = this.tglPelayanan;
    data['jam_daftar_antrean'] = this.jamDaftarAntrean;
    data['jam_mulai_dilayani'] = this.jamMulaiDilayani;
    data['jam_selesai_dilayani'] = this.jamSelesaiDilayani;
    data['status_antrean'] = this.statusAntrean;
    data['hari'] = this.hari;
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    data['id_pasien'] = this.idPasien;
    data['username'] = this.username;
    data['no_handphone'] = this.noHandphone;
    data['kepala_keluarga'] = this.kepalaKeluarga;
    data['nama_lengkap'] = this.namaLengkap;
    data['alamat'] = this.alamat;
    data['tgl_lahir'] = this.tglLahir;
    data['jenis_pasien'] = this.jenisPasien;
    return data;
  }
}