part of 'antrean_sementara_bloc.dart';

@immutable
abstract class AntreanSementaraState {
  const AntreanSementaraState();
}

class StateAntreanSementaraGetPoliLoading extends AntreanSementaraState {}

class StateAntreanSementaraGetPoliSuccess extends AntreanSementaraState {
  final List<Poliklinik> daftarPoli;
  StateAntreanSementaraGetPoliSuccess({@required this.daftarPoli});
}

class StateAntreanSementaraGetPoliFailed extends AntreanSementaraState {
  final String messageFailed;
  StateAntreanSementaraGetPoliFailed({@required this.messageFailed});
}
