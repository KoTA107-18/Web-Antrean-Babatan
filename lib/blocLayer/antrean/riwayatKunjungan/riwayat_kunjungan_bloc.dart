import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'riwayat_kunjungan_event.dart';
part 'riwayat_kunjungan_state.dart';

class RiwayatKunjunganBloc extends Bloc<RiwayatKunjunganEvent, RiwayatKunjunganState> {
  RiwayatKunjunganBloc() : super(StateRiwayatGetPoliLoading());
  String messageError;
  String apiToken;
  List<Poliklinik> daftarPoli = [];

  @override
  Stream<RiwayatKunjunganState> mapEventToState(
    RiwayatKunjunganEvent event,
  ) async* {
    if (event is RiwayatKunjunganEventGetPoli) {
      yield StateRiwayatGetPoliLoading();
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
        yield StateRiwayatGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateRiwayatGetPoliFailed(messageFailed: e.toString());
      }
    }
  }
}
