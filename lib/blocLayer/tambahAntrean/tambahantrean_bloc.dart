import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'tambahantrean_event.dart';
part 'tambahantrean_state.dart';

class TambahantreanBloc extends Bloc<TambahantreanEvent, TambahantreanState> {
  List<Poliklinik> daftarPoli = [];

  TambahantreanBloc() : super(StateTambahAntreanLoading());

  @override
  Stream<TambahantreanState> mapEventToState(
    TambahantreanEvent event,
  ) async* {
    if (event is EventTambahAntreanGetPoli) {
      yield StateTambahAntreanLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StateTambahAntreanSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateTambahAntreanFailed(errMessage: e.toString());
      }
    }

    if (event is EventTambahAntreanSubmitPasien) {
      yield StateTambahAntreanSubmitPasienLoading(daftarPoli: daftarPoli);
      try {
        await RequestApi.registerPasien(event.pasien);
        yield StateTambahAntreanSubmitPasienSuccess(
            message: "Data pasien telah masuk!", daftarPoli: daftarPoli);
      } catch (e) {
        yield StateTambahAntreanSubmitPasienFailed(
            errMessage: e.toString(), daftarPoli: daftarPoli);
      }
    }
  }
}
