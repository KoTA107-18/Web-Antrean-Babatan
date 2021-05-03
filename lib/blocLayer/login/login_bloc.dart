import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_antrean_babatan/dataLayer/dataProvider/requestApi.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isVerified = false;
  String username, password, result;
  LoginBloc() : super(StateLoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is EventTapLogin){
      username = event.username;
      password = event.password;
      yield StateLoginLoading();
      await RequestApi.loginAdministrator(username, password).then((value){
        if(value){
          isVerified = true;
          result = "Login berhasil!";
        } else {
          result = "Login gagal, akun tidak dikenali";
        }

      }).catchError((e){
        result = "Gagal : " + e.toString();
      });
      if(isVerified){
        yield StateLoginSuccess(message: result);
      } else {
        yield StateLoginFailed(errorMessage: result);
      }
    }
  }
}
