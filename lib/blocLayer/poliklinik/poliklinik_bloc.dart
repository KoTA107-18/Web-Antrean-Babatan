import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'poliklinik_event.dart';
part 'poliklinik_state.dart';

class PoliklinikBloc extends Bloc<PoliklinikEvent, PoliklinikState> {
  List<Poliklinik> daftarPoli = [];
  PoliklinikBloc() : super(StatePoliklinikLoading());

  @override
  Stream<PoliklinikState> mapEventToState(
    PoliklinikEvent event,
  ) async* {
    if (event is EventPoliklinikGetPoli) {
      yield StatePoliklinikLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StatePoliklinikSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StatePoliklinikFailed(messageFailed: e.toString());
      }
    }

    if (event is EventPoliklinikAddSubmitPoli) {
      yield StatePoliklinikLoading();
      try {
        await RequestApi.insertPoliklinik(event.dataPoliklinik);
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StatePoliklinikSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StatePoliklinikFailed(messageFailed: e.toString());
      }
    }

    if (event is EventPoliklinikEditSubmitPoli) {
      yield StatePoliklinikLoading();
      try {
        await RequestApi.updatePoliklinik(event.dataPoliklinik);
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StatePoliklinikSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StatePoliklinikFailed(messageFailed: e.toString());
      }
    }
  }
}
