import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/sharedPref.dart';
import 'package:web_antrean_babatan/screenLayer/akunPerawatScreen.dart';
import 'package:web_antrean_babatan/screenLayer/antreanScreen.dart';
import 'package:web_antrean_babatan/screenLayer/antreanSementaraScreen.dart';
import 'package:web_antrean_babatan/screenLayer/dashboardScreen.dart';
import 'package:web_antrean_babatan/screenLayer/poliklinikScreen.dart';
import 'package:web_antrean_babatan/screenLayer/riwayatScreen.dart';
import 'package:web_antrean_babatan/screenLayer/tambahAntreanScreen.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarStateLoadingGetRole());
   bool isAdmin = false;

  @override
  Stream<NavbarState> mapEventToState(
    NavbarEvent event,
  ) async* {
    if(event is NavbarEventGetRole){
      yield NavbarStateLoadingGetRole();
      await SharedPref.getRole().then((value){
        if(value == SharedPref.administrator){
          isAdmin = true;
        } else {
          isAdmin = false;
        }
      });
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: DashboardScreen());
    }

    if(event is NavbarEventLoadDashboard){
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: DashboardScreen());
    }

    if(event is NavbarEventLoadAntrean){
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: AntreanScreen());
    }

    if(event is NavbarEventLoadAntreanSementara){
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: AntreanSementaraScreen());
    }

    if(event is NavbarEventLoadTambahAntrean){
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: TambahAntreanScreen());
    }

    if(event is NavbarEventLoadPoliklinik){
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: PoliklinikScreen());
    }

    if(event is NavbarEventLoadRiwayat){
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: RiwayatScreen());
    }

    if(event is NavbarEventLoadAkunPerawat){
      yield NavbarStateSuccessGetRole(isAdmin: isAdmin, page: AkunPerawatScreen());
    }
  }
}
