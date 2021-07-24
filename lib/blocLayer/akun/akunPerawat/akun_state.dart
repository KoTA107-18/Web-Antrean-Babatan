part of 'akun_bloc.dart';

@immutable
abstract class AkunState {
  const AkunState();
}

class AkunStateLoading extends AkunState {}

class AkunStateSuccess extends AkunState {
  List<Poliklinik> daftarPoli;
  List<ResponseGetPerawat> daftarPerawat;
  AkunStateSuccess({@required this.daftarPoli, this.daftarPerawat});
}

class AkunStateFailed extends AkunState {
  final String messageFailed;
  AkunStateFailed({@required this.messageFailed});
}
