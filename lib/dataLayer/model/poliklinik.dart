import 'jadwal.dart';

class Poliklinik {
  int idPoli;
  String namaPoli;
  String descPoli;
  int statusPoli;
  int rerataWaktuPelayanan;
  int batasBooking;
  List<Jadwal> jadwal;

  Poliklinik(
      {this.idPoli = 0,
        this.namaPoli,
        this.descPoli,
        this.statusPoli = 0,
        this.rerataWaktuPelayanan,
        this.batasBooking,
        this.jadwal});

  Poliklinik.fromJson(Map<String, dynamic> json) {
    idPoli = int.parse(json['id_poli']);
    namaPoli = json['nama_poli'].toString();
    descPoli = json['desc_poli'].toString();
    statusPoli = int.parse(json['status_poli']);
    rerataWaktuPelayanan = int.parse(json['rerata_waktu_pelayanan']);
    batasBooking = int.parse(json['batas_booking']);
    if (json['jadwal'] != null) {
      jadwal = new List<Jadwal>();
      json['jadwal'].forEach((v) {
        jadwal.add(new Jadwal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    data['desc_poli'] = this.descPoli;
    data['status_poli'] = this.statusPoli;
    data['rerata_waktu_pelayanan'] = this.rerataWaktuPelayanan;
    data['batas_booking'] = this.batasBooking;
    if (this.jadwal != null) {
      data['jadwal'] = this.jadwal.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String jadwalToString(){
    String daftarHari = "";
    for (var i=0; i<jadwal.length; i++) {
      if(i+1 == jadwal.length){
        daftarHari += jadwal[i].hari + ".";
      } else {
        daftarHari += jadwal[i].hari + ", ";
      }
    }

    if(daftarHari==""){
      daftarHari = "-";
    }
    return daftarHari;
  }
}