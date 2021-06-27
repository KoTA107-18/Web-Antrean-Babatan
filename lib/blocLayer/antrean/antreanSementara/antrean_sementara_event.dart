part of 'antrean_sementara_bloc.dart';

@immutable
abstract class AntreanSementaraEvent {
  const AntreanSementaraEvent();
}

class EventAntreanSementaraGetPoli extends AntreanSementaraEvent {}

class EventAntreanSementaraEditJadwalPasien extends AntreanSementaraEvent {
  final JadwalPasien pasien;
  EventAntreanSementaraEditJadwalPasien({@required this.pasien});
}