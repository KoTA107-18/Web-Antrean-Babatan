part of 'poliklinik_bloc.dart';

@immutable
abstract class PoliklinikEvent {
  const PoliklinikEvent();
}

class EventPoliklinikGetPoli extends PoliklinikEvent {}

class EventPoliklinikAddPoli extends PoliklinikEvent {}

class EventPoliklinikAddSubmitPoli extends PoliklinikEvent {
  final Map<String, dynamic> dataPoliklinik;
  EventPoliklinikAddSubmitPoli({@required this.dataPoliklinik});
}
