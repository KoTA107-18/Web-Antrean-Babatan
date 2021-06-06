class Jadwal {
  int idPoli;
  String hari;
  String jamBukaBooking;
  String jamTutupBooking;

  Jadwal({this.idPoli, this.hari, this.jamBukaBooking, this.jamTutupBooking});

  Jadwal.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    hari = json['hari'];
    jamBukaBooking = json['jam_buka_booking'];
    jamTutupBooking = json['jam_tutup_booking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['hari'] = this.hari;
    data['jam_buka_booking'] = this.jamBukaBooking;
    data['jam_tutup_booking'] = this.jamTutupBooking;
    return data;
  }
}