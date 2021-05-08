import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/kartuAntre.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'tambahantrean_event.dart';
part 'tambahantrean_state.dart';

class TambahantreanBloc extends Bloc<TambahantreanEvent, TambahantreanState> {
  String username;
  Poliklinik poliklinikTujuan;
  int jenisPasien = 0;
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

    if (event is EventTambahAntreanRadioUmum) {
      jenisPasien = 0;
      yield StateTambahAntreanPilihJenisPasien(
          daftarPoli: daftarPoli, isUmum: jenisPasien);
    }

    if (event is EventTambahAntreanRadioBPJS) {
      jenisPasien = 1;
      yield StateTambahAntreanPilihJenisPasien(
          daftarPoli: daftarPoli, isUmum: jenisPasien);
    }

    if (event is EventTambahAntreanSubmitPoliTujuan) {
      poliklinikTujuan = event.poliklinik;
    }

    if (event is EventTambahAntreanSubmitAntreanBaru) {
      yield StateTambahAntreanSubmitPasienLoading(daftarPoli: daftarPoli);
      username = event.username;
      try {
        var resultCheck = await RequestApi.checkAlreadyRegisterQueue(username);
        if (resultCheck == false) {
          KartuAntre tiket = KartuAntre(
              idJadwalPasien: 0,
              idPoli: poliklinikTujuan.idPoli,
              idHari: DateTime.now().weekday,
              username: username.toString(),
              nomorAntrean: 0,
              tipeBooking: 0,
              tglPelayanan:
                  "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
              jamDaftarAntrean:
                  "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}",
              jamMulaiDilayani: "NULL",
              jamSelesaiDilayani: "NULL",
              statusAntrean: 1);
          var resultRegister = await RequestApi.registerAntreanHariIni(tiket);
          if (resultRegister) {
            yield StateTambahAntreanSubmitPasienSuccess(
                message: "Data antrean pasien telah masuk!",
                daftarPoli: daftarPoli);
          } else {
            yield StateTambahAntreanSubmitPasienFailed(
                errMessage: "Pendaftaran gagal!", daftarPoli: daftarPoli);
          }
        } else {
          yield StateTambahAntreanSubmitPasienFailed(
              errMessage:
                  "Pasien tersebut masih memiliki nomor antrean yang belum diproses.",
              daftarPoli: daftarPoli);
        }
      } catch (e) {
        yield StateTambahAntreanFailed(errMessage: e.toString());
      }
    }
  }
}
