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
