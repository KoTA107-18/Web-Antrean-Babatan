part of 'antrean_sementara_bloc.dart';

@immutable
abstract class AntreanSementaraEvent {
  const AntreanSementaraEvent();
}

class EventAntreanSementaraGetPoli extends AntreanSementaraEvent {}

class EventAntreanSementaraGetAntreanList extends AntreanSementaraEvent {}