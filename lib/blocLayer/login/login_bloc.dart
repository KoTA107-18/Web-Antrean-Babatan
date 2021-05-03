import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String username;
  String password;
  LoginBloc() : super(StateLoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is EventIsiUsername){
      username = event.username;
      yield StateLoginIsiUsername(username: username);
    } else if(event is EventIsiPassword){
      password = event.password;
      yield LoginIsiPasswordState(password: password);
    } else {
      yield StateLoginLoading();
      // Eksekusi load.
      print(username);
      print(password);
      Future.delayed(Duration(milliseconds: 500));
      var hasil = true;
      if(hasil){
        yield StateLoginSuccess(message: "Login berhasil");
      } else {
        yield StateLoginFailed(errorMessage: "Login gagal!");
      }
    }
  }
}
