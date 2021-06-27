part of 'antrean_bloc.dart';

@immutable
abstract class AntreanEvent {
  const AntreanEvent();
}

class EventAntreanGetPoli extends AntreanEvent {}

class EventAntreanEditJadwalPasien extends AntreanEvent {
  final JadwalPasien pasien;
  EventAntreanEditJadwalPasien({@required this.pasien});
}
