import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/model/responseGetPerawat.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'akun_perawat_event.dart';
part 'akun_perawat_state.dart';

class AkunPerawatBloc extends Bloc<AkunPerawatEvent, AkunPerawatState> {
  List<Poliklinik> daftarPoli = [];
  List<ResponseGetPerawat> daftarPerawat = [];
  String apiToken;
  AkunPerawatBloc() : super(AkunPerawatStateLoading());

  @override
  Stream<AkunPerawatState> mapEventToState(
    AkunPerawatEvent event,
  ) async* {
    if(event is AkunPerawatEventGetData){
      yield AkunPerawatStateLoading();
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

        await RequestApi.getAllPerawat(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => ResponseGetPerawat.fromJson(aJson))
                .toList();
          }
        });
        yield AkunPerawatStateSuccess(daftarPoli: daftarPoli, daftarPerawat: daftarPerawat);
      } catch (e) {
        yield AkunPerawatStateFailed(messageFailed: e.toString());
      }
    }

    if(event is AkunPerawatEventSubmitEdit){
      yield AkunPerawatStateLoading();
      try {
        await RequestApi.editPerawat(event.perawat, apiToken);
        await RequestApi.getAllPoliklinik(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        await RequestApi.getAllPerawat(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => ResponseGetPerawat.fromJson(aJson))
                .toList();
          }
        });
        yield AkunPerawatStateSuccess(daftarPoli: daftarPoli, daftarPerawat: daftarPerawat);
      } catch (e) {
        yield AkunPerawatStateFailed(messageFailed: e.toString());
      }
    }

    if(event is AkunPerawatEventSubmitAdd){
      yield AkunPerawatStateLoading();
      print(event.perawat.toJson());
      try {
        await RequestApi.addPerawat(event.perawat, apiToken);
        await RequestApi.getAllPoliklinik(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        await RequestApi.getAllPerawat(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => ResponseGetPerawat.fromJson(aJson))
                .toList();
          }
        });
        yield AkunPerawatStateSuccess(daftarPoli: daftarPoli, daftarPerawat: daftarPerawat);
      } catch (e) {
        yield AkunPerawatStateFailed(messageFailed: e.toString());
      }
    }

    if(event is AkunPerawatEventSubmitDelete){
      yield AkunPerawatStateLoading();
      try {
        await RequestApi.deletePerawat(event.idPerawat, apiToken);
        await RequestApi.getAllPoliklinik(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        await RequestApi.getAllPerawat(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => ResponseGetPerawat.fromJson(aJson))
                .toList();
          }
        });
        yield AkunPerawatStateSuccess(daftarPoli: daftarPoli, daftarPerawat: daftarPerawat);
      } catch (e) {
        yield AkunPerawatStateFailed(messageFailed: e.toString());
      }
    }
  }
}
