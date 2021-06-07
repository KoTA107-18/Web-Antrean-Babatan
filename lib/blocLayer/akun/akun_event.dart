part of 'akun_bloc.dart';

@immutable
abstract class AkunEvent {
  const AkunEvent();
}

class AkunEventGetData extends AkunEvent {}

class AkunEventSubmitEdit extends AkunEvent {
  Perawat perawat;
  AkunEventSubmitEdit({@required this.perawat});
}