import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'akun_perawat_event.dart';
part 'akun_perawat_state.dart';

class AkunPerawatBloc extends Bloc<AkunPerawatEvent, AkunPerawatState> {
  List<Poliklinik> daftarPoli = [];
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
        yield AkunPerawatStateSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield AkunPerawatStateFailed(messageFailed: e.toString());
      }
    }
  }
}
