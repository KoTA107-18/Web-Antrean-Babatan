part of 'akun_perawat_bloc.dart';

@immutable
abstract class AkunPerawatEvent {
  const AkunPerawatEvent();
}

class AkunPerawatEventGetData extends AkunPerawatEvent {}
