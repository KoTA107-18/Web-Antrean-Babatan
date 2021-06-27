part of 'antrean_selesai_bloc.dart';

@immutable
abstract class AntreanSelesaiEvent {
  const AntreanSelesaiEvent();
}

class EventAntreanSelesaiGetPoli extends AntreanSelesaiEvent {}