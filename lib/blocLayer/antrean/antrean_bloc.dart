import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'antrean_event.dart';
part 'antrean_state.dart';

class AntreanBloc extends Bloc<AntreanEvent, AntreanState> {
  String messageError;
  List<Poliklinik> daftarPoli = [];
  AntreanBloc() : super(StateAntreanGetPoliLoading());

  @override
  Stream<AntreanState> mapEventToState(
    AntreanEvent event,
  ) async* {
    if (event is EventAntreanGetPoli) {
      yield StateAntreanGetPoliLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StateAntreanGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateAntreanGetPoliFailed(messageFailed: e.toString());
      }
    }

    if (event is EventAntreanGetAntreanPoli) {
      print("Bingo");
      try {
        await RequestApi.getAntreanWithId(event.idPoli).then((snapshot) {
          print(snapshot);
        });
        //yield StateAntreanGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        //yield StateAntreanGetPoliFailed(messageFailed: e.toString());
      }
    }
  }
}
