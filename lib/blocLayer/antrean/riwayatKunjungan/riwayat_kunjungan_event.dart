part of 'riwayat_kunjungan_bloc.dart';

@immutable
abstract class RiwayatKunjunganEvent {
  const RiwayatKunjunganEvent();
}

class RiwayatKunjunganEventGetPoli extends RiwayatKunjunganEvent {}

class RiwayatKunjunganEventGetAntreanList extends RiwayatKunjunganEvent {}