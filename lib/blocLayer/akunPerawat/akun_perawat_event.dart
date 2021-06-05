part of 'akun_perawat_bloc.dart';

@immutable
abstract class AkunPerawatEvent {
  const AkunPerawatEvent();
}

class AkunPerawatEventGetData extends AkunPerawatEvent {}

class AkunPerawatEventSubmitEdit extends AkunPerawatEvent {
  Perawat perawat;
  AkunPerawatEventSubmitEdit({@required this.perawat});
}

class AkunPerawatEventSubmitAdd extends AkunPerawatEvent {
  Perawat perawat;
  AkunPerawatEventSubmitAdd({@required this.perawat});
}

class AkunPerawatEventSubmitDelete extends AkunPerawatEvent {
  int idPerawat;
  AkunPerawatEventSubmitDelete({@required this.idPerawat});
}
