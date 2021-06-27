part of 'antrean_bloc.dart';

@immutable
abstract class AntreanState {
  const AntreanState();
}

class StateAntreanGetPoliLoading extends AntreanState {}

class StateAntreanGetPoliSuccess extends AntreanState {
  final List<Poliklinik> daftarPoli;
  StateAntreanGetPoliSuccess({@required this.daftarPoli});
}

class StateAntreanGetPoliFailed extends AntreanState {
  final String messageFailed;
  StateAntreanGetPoliFailed({@required this.messageFailed});
}
