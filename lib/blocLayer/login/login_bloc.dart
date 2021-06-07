import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/sharedPref.dart';
import 'package:web_antrean_babatan/dataLayer/model/perawat.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  int choiceRole = 0;
  bool isVerified = false;
  String username, password, result;
  List<Perawat> daftarPerawat = [];
  LoginBloc() : super(StateLoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is EventTapLogin){
      username = event.username;
      password = event.password;
      yield StateLoginLoading();
      if(choiceRole == 0){
        await RequestApi.loginAdministrator(username, password).then((value) async {
          if(value){
            await SharedPref.saveLogin(username, choiceRole);
            isVerified = true;
            result = "Login berhasil!";
          } else {
            result = "Login gagal, akun tidak dikenali";
          }

        }).catchError((e){
          result = "Gagal : " + e.toString();
        });
      } else {
        await RequestApi.loginPerawat(username, password).then((value) async {
          if(value != null){
            var resultSnapshot = value as List;
            daftarPerawat = resultSnapshot
                .map((aJson) => Perawat.fromJson(aJson))
                .toList();

            await SharedPref.saveLogin(username, choiceRole);
            await SharedPref.savePoli(daftarPerawat[0].idPoli);
            isVerified = true;
            result = "Login berhasil!";
          } else {
            result = "Login gagal, akun tidak dikenali";
          }

        }).catchError((e){
          result = "Gagal : " + e.toString();
        });
      }

      if(isVerified){
        yield StateLoginSuccess(message: result);
      } else {
        yield StateLoginFailed(errorMessage: result);
      }
    }

    if(event is EventLoginChooseAdmin){
      choiceRole = 0;
      yield StateLoginChooseRole(chooseRole: choiceRole);
    }

    if(event is EventLoginChoosePerawat){
      choiceRole = 1;
      yield StateLoginChooseRole(chooseRole: choiceRole);
    }
  }
}
