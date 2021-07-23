part of 'akun_perawat_bloc.dart';

@immutable
abstract class AkunPerawatState {
  const AkunPerawatState();
}

class AkunPerawatStateLoading extends AkunPerawatState {}

class AkunPerawatStateSuccess extends AkunPerawatState {
  List<Poliklinik> daftarPoli;
  List<ResponseGetPerawat> daftarPerawat;
  AkunPerawatStateSuccess({@required this.daftarPoli, this.daftarPerawat});
}

class AkunPerawatStateFailed extends AkunPerawatState {
  final String messageFailed;
  AkunPerawatStateFailed({@required this.messageFailed});
}
