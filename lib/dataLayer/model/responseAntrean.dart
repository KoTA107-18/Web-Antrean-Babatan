import 'dart:convert';

List<ResponseAntrean> responseAntreanFromJson(String str) => List<ResponseAntrean>.from(json.decode(str).map((x) => ResponseAntrean.fromJson(x)));

String responseAntreanToJson(List<ResponseAntrean> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseAntrean {
  ResponseAntrean({
    this.idPoli,
    this.idPasien,
    this.nomorAntrean,
    this.tipeBooking,
    this.tglPelayanan,
    this.jamBooking,
    this.waktuDaftarAntrean,
    this.jamMulaiDilayani,
    this.jamSelesaiDilayani,
    this.statusAntrean,
    this.hari,
    this.pasien,
    this.poliklinik,
  });

  String idPoli;
  String idPasien;
  String nomorAntrean;
  String tipeBooking;
  String tglPelayanan;
  String jamBooking;
  String waktuDaftarAntrean;
  String jamMulaiDilayani;
  String jamSelesaiDilayani;
  String statusAntrean;
  String hari;
  PasienAntrean pasien;
  PoliklinikAntrean poliklinik;

  factory ResponseAntrean.fromJson(Map<String, dynamic> json) => ResponseAntrean(
    idPoli: json["id_poli"],
    idPasien: json["id_pasien"],
    nomorAntrean: json["nomor_antrean"],
    tipeBooking: json["tipe_booking"],
    tglPelayanan: json["tgl_pelayanan"],
    jamBooking: json["jam_booking"],
    waktuDaftarAntrean: json["waktu_daftar_antrean"],
    jamMulaiDilayani: json["jam_mulai_dilayani"],
    jamSelesaiDilayani: json["jam_selesai_dilayani"],
    statusAntrean: json["status_antrean"],
    hari: json["hari"],
    pasien: PasienAntrean.fromJson(json["pasien"]),
    poliklinik: PoliklinikAntrean.fromJson(json["poliklinik"]),
  );

  Map<String, dynamic> toJson() => {
    "id_poli": idPoli,
    "id_pasien": idPasien,
    "nomor_antrean": nomorAntrean,
    "tipe_booking": tipeBooking,
    "tgl_pelayanan": tglPelayanan,
    "jam_booking": jamBooking,
    "waktu_daftar_antrean": waktuDaftarAntrean,
    "jam_mulai_dilayani": jamMulaiDilayani,
    "jam_selesai_dilayani": jamSelesaiDilayani,
    "status_antrean": statusAntrean,
    "hari": hari,
    "pasien": pasien.toJson(),
    "poliklinik": poliklinik.toJson(),
  };
}

class PasienAntrean {
  PasienAntrean({
    this.idPasien,
    this.username,
    this.noHandphone,
    this.kepalaKeluarga,
    this.namaLengkap,
    this.alamat,
    this.tglLahir,
    this.jenisPasien,
  });

  String idPasien;
  String username;
  String noHandphone;
  String kepalaKeluarga;
  String namaLengkap;
  String alamat;
  String tglLahir;
  String jenisPasien;

  factory PasienAntrean.fromJson(Map<String, dynamic> json) => PasienAntrean(
    idPasien: json["id_pasien"],
    username: json["username"],
    noHandphone: json["no_handphone"],
    kepalaKeluarga: json["kepala_keluarga"],
    namaLengkap: json["nama_lengkap"],
    alamat: json["alamat"],
    tglLahir: json["tgl_lahir"],
    jenisPasien: json["jenis_pasien"],
  );

  Map<String, dynamic> toJson() => {
    "id_pasien": idPasien,
    "username": username,
    "no_handphone": noHandphone,
    "kepala_keluarga": kepalaKeluarga,
    "nama_lengkap": namaLengkap,
    "alamat": alamat,
    "tgl_lahir": tglLahir,
    "jenis_pasien": jenisPasien,
  };
}

class PoliklinikAntrean {
  PoliklinikAntrean({
    this.idPoli,
    this.namaPoli,
  });

  String idPoli;
  String namaPoli;

  factory PoliklinikAntrean.fromJson(Map<String, dynamic> json) => PoliklinikAntrean(
    idPoli: json["id_poli"],
    namaPoli: json["nama_poli"],
  );

  Map<String, dynamic> toJson() => {
    "id_poli": idPoli,
    "nama_poli": namaPoli,
  };
}
