part of 'tambahantrean_bloc.dart';

@immutable
abstract class TambahantreanEvent {
  const TambahantreanEvent();
}

class EventTambahAntreanGetPoli extends TambahantreanEvent {}

class EventTambahAntreanSubmitPasien extends TambahantreanEvent {
  final Pasien pasien;
  EventTambahAntreanSubmitPasien({@required this.pasien});
}

class EventTambahAntreanRadioUmum extends TambahantreanEvent {}

class EventTambahAntreanRadioBPJS extends TambahantreanEvent {}

class EventTambahAntreanPilihTanggal extends TambahantreanEvent {
  final String tanggal;
  EventTambahAntreanPilihTanggal({this.tanggal});
}

class EventTambahAntreanSubmitPoliTujuan extends TambahantreanEvent {
  final Poliklinik poliklinik;
  EventTambahAntreanSubmitPoliTujuan({@required this.poliklinik});
}

class EventTambahAntreanSubmitAntreanBaru extends TambahantreanEvent {
  final bool isGawat;
  final Pasien pasien;
  EventTambahAntreanSubmitAntreanBaru({@required this.pasien, this.isGawat});
}
