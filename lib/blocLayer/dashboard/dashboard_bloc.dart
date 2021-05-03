import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  String messageError;
  List<Poliklinik> daftarPoli = [];
  DashboardBloc() : super(StateDashboardLoading());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if(event is EventDashboardGetPoli){
      yield StateDashboardLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot){
          if(snapshot != null){
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield StateDashboardSuccess(daftarPoli: daftarPoli);
      } catch(e) {
        yield StateDashboardFailed(messageFailed: e.toString());
      }
    }

    if(event is EventDashboardChangeStatusPoli){
      if(daftarPoli[event.indexPoli].statusPoli == 1){
        daftarPoli[event.indexPoli].statusPoli = 0;
      } else {
        daftarPoli[event.indexPoli].statusPoli = 1;
      }
    }

    if(event is EventDashboardBukaPortal){
      for(var i in daftarPoli)
        print(i.namaPoli + " " + i.statusPoli.toString());
    }

    if(event is EventDashboardTutupPortal){
      for(var i in daftarPoli)
        print(i.namaPoli + " " + i.statusPoli.toString());
    }
  }
}
