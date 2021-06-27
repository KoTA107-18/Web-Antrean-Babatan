part of 'riwayat_kunjungan_bloc.dart';

@immutable
abstract class RiwayatKunjunganState {
  const RiwayatKunjunganState();
}

class StateRiwayatGetPoliLoading extends RiwayatKunjunganState {}

class StateRiwayatGetPoliSuccess extends RiwayatKunjunganState {
  final List<Poliklinik> daftarPoli;
  StateRiwayatGetPoliSuccess({@required this.daftarPoli});
}

class StateRiwayatGetPoliFailed extends RiwayatKunjunganState {
  final String messageFailed;
  StateRiwayatGetPoliFailed({@required this.messageFailed});
}
