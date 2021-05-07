part of 'poliklinik_bloc.dart';

@immutable
abstract class PoliklinikEvent {
  const PoliklinikEvent();
}

class EventPoliklinikGetPoli extends PoliklinikEvent {}