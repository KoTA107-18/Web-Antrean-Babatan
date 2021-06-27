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

class EventTambahAntreanSubmitPoliTujuan extends TambahantreanEvent {
  final Poliklinik poliklinik;
  EventTambahAntreanSubmitPoliTujuan({@required this.poliklinik});
}

class EventTambahAntreanSubmitAntreanBaru extends TambahantreanEvent {
  final String username;
  EventTambahAntreanSubmitAntreanBaru({@required this.username});
}
