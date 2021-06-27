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
        var roleValue = await SharedPref.getRole();
        if(roleValue == SharedPref.administrator){
          isAdmin = true;
        }

        await RequestApi.getInfoPoliklinik().then((snapshot) {
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

    if (event is EventDashboardChangeStatusPoli) {
      if (daftarPoli[event.indexPoli].statusPoli == 1) {
        daftarPoli[event.indexPoli].statusPoli = 0;
      } else {
        daftarPoli[event.indexPoli].statusPoli = 1;
      }
    }

    if (event is EventDashboardBukaPortal) {
      yield StateDashboardLoading();
      try {
        await RequestApi.updateStatus(daftarPoli);
        await RequestApi.getInfoPoliklinik().then((snapshot) {
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
