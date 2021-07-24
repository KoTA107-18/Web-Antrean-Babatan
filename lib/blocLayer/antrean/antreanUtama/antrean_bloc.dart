import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'antrean_event.dart';
part 'antrean_state.dart';

class AntreanBloc extends Bloc<AntreanEvent, AntreanState> {
  String messageError;
  String apiToken;
  List<Poliklinik> daftarPoli = [];
  AntreanBloc() : super(StateAntreanGetPoliLoading());

  @override
  Stream<AntreanState> mapEventToState(
    AntreanEvent event,
  ) async* {
    if (event is EventAntreanGetPoli) {
      yield StateAntreanGetPoliLoading();
      try {
        apiToken = await SharedPref.getToken();
        var roleValue = await SharedPref.getRole();
        if(roleValue == SharedPref.administrator){
          await RequestApi.getAllPoliklinik(apiToken).then((snapshot) {
            if (snapshot != null) {
              var resultSnapshot = snapshot as List;
              daftarPoli = resultSnapshot
                  .map((aJson) => Poliklinik.fromJson(aJson))
                  .toList();
            }
          });
        } else {
          var idPoli = await SharedPref.getPoli();
          await RequestApi.getPoliklinik(idPoli, apiToken).then((snapshot) {
            if (snapshot != null) {
              var resultSnapshot = snapshot as List;
              daftarPoli = resultSnapshot
                  .map((aJson) => Poliklinik.fromJson(aJson))
                  .toList();
            }
          });
        }
        yield StateAntreanGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateAntreanGetPoliFailed(messageFailed: e.toString());
      }
    }

    if (event is EventAntreanEditJadwalPasien) {
      yield StateAntreanGetPoliLoading();
      try {
        await RequestApi.editAntrean(event.pasien, apiToken);
        yield StateAntreanGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateAntreanGetPoliFailed(messageFailed: e.toString());
      }
    }
  }
}
