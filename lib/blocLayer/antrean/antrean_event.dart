part of 'antrean_bloc.dart';

@immutable
abstract class AntreanEvent {
  const AntreanEvent();
}

class EventAntreanGetPoli extends AntreanEvent {}

class EventAntreanGetAntreanPoli extends AntreanEvent {
  final String idPoli;
  EventAntreanGetAntreanPoli({@required this.idPoli});
}
