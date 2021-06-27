part of 'tambahantrean_bloc.dart';

@immutable
abstract class TambahantreanState {
  const TambahantreanState();
}

class StateTambahAntreanLoading extends TambahantreanState {}

class StateTambahAntreanSuccess extends TambahantreanState {
  final List<Poliklinik> daftarPoli;
  StateTambahAntreanSuccess({@required this.daftarPoli});
}

class StateTambahAntreanFailed extends TambahantreanState {
  final String errMessage;
  StateTambahAntreanFailed({@required this.errMessage});
}

class StateTambahAntreanSubmitPasienLoading extends TambahantreanState {
  final List<Poliklinik> daftarPoli;
  StateTambahAntreanSubmitPasienLoading({@required this.daftarPoli});
}

class StateTambahAntreanSubmitPasienSuccess extends TambahantreanState {
  final List<Poliklinik> daftarPoli;
  final String message;
  StateTambahAntreanSubmitPasienSuccess(
      {@required this.message, this.daftarPoli});
}

class StateTambahAntreanSubmitPasienFailed extends TambahantreanState {
  final List<Poliklinik> daftarPoli;
  final String errMessage;
  StateTambahAntreanSubmitPasienFailed(
      {@required this.errMessage, this.daftarPoli});
}

class StateTambahAntreanPilihJenisPasien extends TambahantreanState {
  final List<Poliklinik> daftarPoli;
  final int isUmum;
  StateTambahAntreanPilihJenisPasien({@required this.daftarPoli, this.isUmum});
}
