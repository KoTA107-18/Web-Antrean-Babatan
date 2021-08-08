import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/api/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/infoPoliklinik.dart';
import 'package:web_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  bool isAdmin = false;
  String apiToken;
  String messageError;
  List<InfoPoliklinik> daftarPoli = [];
  DashboardBloc() : super(StateDashboardLoading());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is EventDashboardGetPoli) {
      yield StateDashboardLoading();
      try {
        apiToken = await SharedPref.getToken();
        var roleValue = await SharedPref.getRole();
        if(roleValue == SharedPref.administrator){
          isAdmin = true;
        }
        await RequestApi.getInfoPoliklinik(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => InfoPoliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StateDashboardSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateDashboardFailed(messageFailed: e.toString());
      }
    }

    if (event is EventDashboardGetPoliSilent) {
      List<InfoPoliklinik> daftarPoliNew = [];
      try {
        var roleValue = await SharedPref.getRole();
        if(roleValue == SharedPref.administrator){
          isAdmin = true;
        }

        await RequestApi.getInfoPoliklinik(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoliNew = resultSnapshot
                .map((aJson) => InfoPoliklinik.fromJson(aJson))
                .toList();
            if(daftarPoli.length == daftarPoliNew.length){
              for(var i=0; i<daftarPoli.length; i++){
                daftarPoli[i].idPoli = daftarPoliNew[i].idPoli;
                daftarPoli[i].namaPoli = daftarPoliNew[i].namaPoli;
                daftarPoli[i].totalAntrean = daftarPoliNew[i].totalAntrean;
                daftarPoli[i].antreanSementara = daftarPoliNew[i].antreanSementara;
                daftarPoli[i].nomorAntrean = daftarPoliNew[i].nomorAntrean;
              }
            } else {
              daftarPoli = daftarPoliNew;
            }
          }
        });
        yield StateDashboardSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateDashboardSuccess(daftarPoli: daftarPoli);
      }
    }

    if (event is EventDashboardChangeStatusPoli) {
      if (daftarPoli[event.indexPoli].statusPoli == 1.toString()) {
        daftarPoli[event.indexPoli].statusPoli = 0.toString();
      } else {
        daftarPoli[event.indexPoli].statusPoli = 1.toString();
      }
    }

    if (event is EventDashboardBukaPortal) {
      yield StateDashboardLoading();
      try {
        await RequestApi.updateStatus(daftarPoli, apiToken);
        await RequestApi.getInfoPoliklinik(apiToken).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => InfoPoliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StateDashboardSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield StateDashboardFailed(messageFailed: e.toString());
      }
    }
  }
}
