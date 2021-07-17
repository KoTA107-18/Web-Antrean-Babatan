class JadwalPasien {
  int nomorAntrean;
  int tipeBooking;
  String tglPelayanan;
  String jamBooking;
  String waktuDaftarAntrean;
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
        this.jamBooking,
        this.waktuDaftarAntrean,
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
    nomorAntrean = int.parse(json['nomor_antrean']);
    tipeBooking = int.parse(json['tipe_booking']);
    tglPelayanan = json['tgl_pelayanan'].toString();
    jamBooking = json['jam_booking'].toString();
    waktuDaftarAntrean = json['waktu_daftar_antrean'].toString();
    jamMulaiDilayani = json['jam_mulai_dilayani'].toString();
    jamSelesaiDilayani = json['jam_selesai_dilayani'].toString();
    statusAntrean = int.parse(json['status_antrean']);
    hari = json['hari'].toString();
    idPoli = int.parse(json['id_poli']);
    namaPoli = json['nama_poli'].toString();
    idPasien = int.parse(json['id_pasien']);
    username = json['username'].toString();
    noHandphone = json['no_handphone'].toString();
    kepalaKeluarga = json['kepala_keluarga'].toString();
    namaLengkap = json['nama_lengkap'].toString();
    alamat = json['alamat'].toString();
    tglLahir = json['tgl_lahir'].toString();
    jenisPasien = int.parse(json['jenis_pasien']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomor_antrean'] = this.nomorAntrean;
    data['tipe_booking'] = this.tipeBooking;
    data['tgl_pelayanan'] = this.tglPelayanan;
    data['jam_booking'] = this.jamBooking;
    data['waktu_daftar_antrean'] = this.waktuDaftarAntrean;
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