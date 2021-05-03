part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class StateLoginInitial extends LoginState {}

class StateLoginIsiUsername extends LoginState {
  final String username;
  StateLoginIsiUsername({@required this.username});
}

class LoginIsiPasswordState extends LoginState {
  final String password;
  LoginIsiPasswordState({@required this.password});
}

class StateLoginLoading extends LoginState {}

class StateLoginSuccess extends LoginState {
  final String message;
  StateLoginSuccess({this.message});
}

class StateLoginFailed extends LoginState {
  final String errorMessage;
  StateLoginFailed({this.errorMessage});
}

