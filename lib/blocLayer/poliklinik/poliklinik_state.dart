part of 'poliklinik_bloc.dart';

@immutable
abstract class PoliklinikState {
  const PoliklinikState();
}

class StatePoliklinikLoading extends PoliklinikState {}

class StatePoliklinikSuccess extends PoliklinikState {
  final List<Poliklinik> daftarPoli;
  StatePoliklinikSuccess({@required this.daftarPoli});
}

class StatePoliklinikFailed extends PoliklinikState {
  final String messageFailed;
  StatePoliklinikFailed({@required this.messageFailed});
}
