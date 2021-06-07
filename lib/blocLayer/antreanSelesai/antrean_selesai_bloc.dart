import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/sharedPref.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'antrean_selesai_event.dart';
part 'antrean_selesai_state.dart';

class AntreanSelesaiBloc extends Bloc<AntreanSelesaiEvent, AntreanSelesaiState> {
  AntreanSelesaiBloc() : super(StateAntreanSelesaiGetPoliLoading());
  String messageError;
  List<Poliklinik> daftarPoli = [];

  @override
  Stream<AntreanSelesaiState> mapEventToState(
    AntreanSelesaiEvent event,
  ) async* {
    if (event is EventAntreanSelesaiGetPoli) {
      yield StateAntreanSelesaiGetPoliLoading();
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
        yield StateAntreanSelesaiGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateAntreanSelesaiGetPoliFailed(messageFailed: e.toString());
      }
    }
  }
}
