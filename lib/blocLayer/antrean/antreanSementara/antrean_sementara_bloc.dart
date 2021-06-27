import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'antrean_sementara_event.dart';
part 'antrean_sementara_state.dart';

class AntreanSementaraBloc extends Bloc<AntreanSementaraEvent, AntreanSementaraState> {
  AntreanSementaraBloc() : super(StateAntreanSementaraGetPoliLoading());
  String messageError;
  List<Poliklinik> daftarPoli = [];

  @override
  Stream<AntreanSementaraState> mapEventToState(
    AntreanSementaraEvent event,
  ) async* {
    if (event is EventAntreanSementaraGetPoli) {
      yield StateAntreanSementaraGetPoliLoading();
      try {
        var roleValue = await SharedPref.getRole();
        if(roleValue == SharedPref.administrator){
          await RequestApi.getAllPoliklinik().then((snapshot) {
            if (snapshot != null) {
              var resultSnapshot = snapshot as List;
              daftarPoli = resultSnapshot
                  .map((aJson) => Poliklinik.fromJson(aJson))
                  .toList();
            }
          });
        } else {
          var idPoli = await SharedPref.getPoli();
          await RequestApi.getPoliklinik(idPoli).then((snapshot) {
            if (snapshot != null) {
              var resultSnapshot = snapshot as List;
              daftarPoli = resultSnapshot
                  .map((aJson) => Poliklinik.fromJson(aJson))
                  .toList();
            }
          });
        }
        yield StateAntreanSementaraGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateAntreanSementaraGetPoliFailed(messageFailed: e.toString());
      }
    }

    if (event is EventAntreanSementaraEditJadwalPasien) {
      yield StateAntreanSementaraGetPoliLoading();
      try {
        await RequestApi.editAntrean(event.pasien);
        yield StateAntreanSementaraGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateAntreanSementaraGetPoliFailed(messageFailed: e.toString());
      }
    }
  }
}
