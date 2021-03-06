part of 'poliklinik_bloc.dart';

@immutable
abstract class PoliklinikEvent {
  const PoliklinikEvent();
}

class EventPoliklinikGetPoli extends PoliklinikEvent {}

class EventPoliklinikAddSubmitPoli extends PoliklinikEvent {
  final Poliklinik dataPoliklinik;
  EventPoliklinikAddSubmitPoli({@required this.dataPoliklinik});
}

class EventPoliklinikEditSubmitPoli extends PoliklinikEvent {
  final Poliklinik dataPoliklinik;
  EventPoliklinikEditSubmitPoli({@required this.dataPoliklinik});
}
