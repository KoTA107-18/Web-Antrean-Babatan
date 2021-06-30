import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/apiResponse.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'tambahantrean_event.dart';
part 'tambahantrean_state.dart';

class TambahantreanBloc extends Bloc<TambahantreanEvent, TambahantreanState> {
  String username;
  Poliklinik poliklinikTujuan;
  int jenisPasien = 0;
  List<Poliklinik> daftarPoli = [];

  TambahantreanBloc() : super(StateTambahAntreanGetPoliLoading());

  @override
  Stream<TambahantreanState> mapEventToState(
    TambahantreanEvent event,
  ) async* {
    if (event is EventTambahAntreanGetPoli) {
      yield StateTambahAntreanGetPoliLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StateTambahAntreanGetPoliSuccess();
      } catch (e) {
        yield StateTambahAntreanGetPoliFailed(errMessage: e.toString());
      }
    }

    if (event is EventTambahAntreanSubmitPasien) {
      yield StateTambahAntreanSubmitPasienLoading();
      try {
        var resultValidasi = await RequestApi.validasiPasien(event.pasien);
        var response = ApiResponse.fromJson(resultValidasi);
        if(response.success){
          await RequestApi.registerPasien(event.pasien);
          yield StateTambahAntreanSubmitPasienSuccess();
        } else {
          yield StateTambahAntreanSubmitPasienFailed(
              errMessage: response.message);
        }
      } catch (e) {
        yield StateTambahAntreanSubmitPasienFailed(
            errMessage: e.toString());
      }
    }

    if (event is EventTambahAntreanRadioUmum) {
      jenisPasien = 0;
      yield StateTambahAntreanPilihJenisPasien(isUmum: jenisPasien);
    }

    if (event is EventTambahAntreanRadioBPJS) {
      jenisPasien = 1;
      yield StateTambahAntreanPilihJenisPasien(isUmum: jenisPasien);
    }

    if (event is EventTambahAntreanSubmitPoliTujuan) {
      poliklinikTujuan = event.poliklinik;
    }

    if (event is EventTambahAntreanSubmitAntreanBaru) {
      yield StateTambahAntreanSubmitPasienLoading();
      username = event.username;
      try {
        /*
        var resultCheck = await RequestApi.checkAlreadyRegisterQueue(username);
        if (resultCheck == false) {
          JadwalPasien tiket = JadwalPasien(
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
         */
      } catch (e) {
        yield StateTambahAntreanGetPoliFailed(errMessage: e.toString());
      }
    }
  }
}
