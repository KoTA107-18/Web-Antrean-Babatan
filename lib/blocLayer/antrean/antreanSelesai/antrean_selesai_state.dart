part of 'antrean_selesai_bloc.dart';

@immutable
abstract class AntreanSelesaiState {
  const AntreanSelesaiState();
}

class StateAntreanSelesaiGetPoliLoading extends AntreanSelesaiState {}

class StateAntreanSelesaiGetPoliSuccess extends AntreanSelesaiState {
  final List<Poliklinik> daftarPoli;
  StateAntreanSelesaiGetPoliSuccess({@required this.daftarPoli});
}

class StateAntreanSelesaiGetPoliFailed extends AntreanSelesaiState {
  final String messageFailed;
  StateAntreanSelesaiGetPoliFailed({@required this.messageFailed});
}
