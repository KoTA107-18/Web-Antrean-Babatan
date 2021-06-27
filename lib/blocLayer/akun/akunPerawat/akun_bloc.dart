import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'akun_event.dart';
part 'akun_state.dart';

class AkunBloc extends Bloc<AkunEvent, AkunState> {
  var idPerawat = 0;
  List<Poliklinik> daftarPoli = [];
  List<Perawat> daftarPerawat = [];
  AkunBloc() : super(AkunStateLoading());

  @override
  Stream<AkunState> mapEventToState(
    AkunEvent event,
  ) async* {
    if(event is AkunEventGetData){
      yield AkunStateLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        idPerawat = await SharedPref.getIdPerawat();
        await RequestApi.getPerawat(idPerawat.toString()).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => Perawat.fromJson(aJson))
                .toList();
          }
        });
        yield AkunStateSuccess(daftarPoli: daftarPoli, daftarPerawat: daftarPerawat);
      } catch (e) {
        yield AkunStateFailed(messageFailed: e.toString());
      }
    }

    if(event is AkunEventSubmitEdit){
      yield AkunStateLoading();
      try {
        await RequestApi.editPerawat(event.perawat);
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        await RequestApi.getPerawat(idPerawat.toString()).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => Perawat.fromJson(aJson))
                .toList();
          }
        });
        yield AkunStateSuccess(daftarPoli: daftarPoli, daftarPerawat: daftarPerawat);
      } catch (e) {
        yield AkunStateFailed(messageFailed: e.toString());
      }
    }
  }
}
