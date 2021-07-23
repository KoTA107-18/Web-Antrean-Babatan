import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/apiResponse.dart';
import 'package:web_antrean_babatan/dataLayer/model/hari.dart';
import 'package:web_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'tambahantrean_event.dart';
part 'tambahantrean_state.dart';

class TambahantreanBloc extends Bloc<TambahantreanEvent, TambahantreanState> {
  String tglLahir;
  Pasien pasien;
  String apiToken;
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
        apiToken = await SharedPref.getToken();
        await RequestApi.getAllPoliklinik(apiToken).then((snapshot) {
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

    if (event is EventTambahAntreanPilihTanggal) {
      tglLahir = event.tanggal;
      yield StateTambahAntreanPilihTanggal(tanggal: tglLahir);
    }

    if (event is EventTambahAntreanSubmitPoliTujuan) {
      poliklinikTujuan = event.poliklinik;
    }

    if (event is EventTambahAntreanSubmitAntreanBaru) {
      yield StateTambahAntreanSubmitAntreanLoading();
      pasien = event.pasien;
      Map<String , dynamic> data = {
        'nama_lengkap' : pasien.namaLengkap,
        'tgl_lahir' : pasien.tglLahir,
        'alamat' : pasien.alamat,
        'kepala_keluarga' : pasien.kepalaKeluarga,
        'no_handphone' : pasien.noHandphone,
        'id_poli' : poliklinikTujuan.idPoli,
        'jenis_pasien' : jenisPasien,
        'hari' : convertNumDayToCode(DateTime.now().weekday)
      };
      try {
        var result = false;
        if(event.isGawat){
          result = await RequestApi.insertAntreanGawat(data);
        } else {
          result = await RequestApi.insertAntreanNormal(data);
        }
        if(result == true){
          yield StateTambahAntreanSubmitAntreanSuccess();
        } else {
          yield StateTambahAntreanSubmitAntreanFailed(errMessage: "Gagal Insert");
        }
      } catch (e) {
        yield StateTambahAntreanSubmitAntreanFailed(errMessage: e.toString());
      }
    }
  }

  String convertNumDayToCode(int day) {
    List<String> codeDay = [
      Hari.SENIN,
      Hari.SELASA,
      Hari.RABU,
      Hari.KAMIS,
      Hari.JUMAT,
      Hari.SABTU,
      Hari.MINGGU
    ];
    return codeDay.elementAt(day - 1);
  }
}
