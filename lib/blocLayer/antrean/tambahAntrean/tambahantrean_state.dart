part of 'tambahantrean_bloc.dart';

@immutable
abstract class TambahantreanState {
  const TambahantreanState();
}

class StateTambahAntreanGetPoliLoading extends TambahantreanState {}

class StateTambahAntreanGetPoliSuccess extends TambahantreanState {}

class StateTambahAntreanGetPoliFailed extends TambahantreanState {
  final String errMessage;
  StateTambahAntreanGetPoliFailed({@required this.errMessage});
}

class StateTambahAntreanSubmitPasienLoading extends TambahantreanState {}

class StateTambahAntreanSubmitPasienSuccess extends TambahantreanState {}

class StateTambahAntreanSubmitPasienFailed extends TambahantreanState {
  final String errMessage;
  StateTambahAntreanSubmitPasienFailed(
      {@required this.errMessage});
}

class StateTambahAntreanSubmitAntreanLoading extends TambahantreanState {}

class StateTambahAntreanSubmitAntreanSuccess extends TambahantreanState {}

class StateTambahAntreanSubmitAntreanFailed extends TambahantreanState {
  final String errMessage;
  StateTambahAntreanSubmitAntreanFailed(
      {@required this.errMessage});
}

class StateTambahAntreanPilihJenisPasien extends TambahantreanState {
  final int isUmum;
  StateTambahAntreanPilihJenisPasien({this.isUmum});
}

class StateTambahAntreanPilihTanggal extends TambahantreanState {
  final String tanggal;
  StateTambahAntreanPilihTanggal({this.tanggal});
}