import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'akun_perawat_event.dart';
part 'akun_perawat_state.dart';

class AkunPerawatBloc extends Bloc<AkunPerawatEvent, AkunPerawatState> {
  List<Poliklinik> daftarPoli = [];
  List<Perawat> daftarPerawat = [];
  AkunPerawatBloc() : super(AkunPerawatStateLoading());

  @override
  Stream<AkunPerawatState> mapEventToState(
    AkunPerawatEvent event,
  ) async* {
    if(event is AkunPerawatEventGetData){
      yield AkunPerawatStateLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });

        await RequestApi.getAllPerawat().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => Perawat.fromJson(aJson))
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
        await RequestApi.editPerawat(event.perawat);
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        await RequestApi.getAllPerawat().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => Perawat.fromJson(aJson))
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
      try {
        await RequestApi.addPerawat(event.perawat);
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        await RequestApi.getAllPerawat().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => Perawat.fromJson(aJson))
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
        await RequestApi.deletePerawat(event.idPerawat);
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        await RequestApi.getAllPerawat().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => Perawat.fromJson(aJson))
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
