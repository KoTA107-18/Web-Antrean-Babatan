part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class StateLoginInitial extends LoginState {}

class StateLoginLoading extends LoginState {}

class StateLoginSuccess extends LoginState {
  final String message;
  StateLoginSuccess({this.message});
}

class StateLoginFailed extends LoginState {
  final String errorMessage;
  StateLoginFailed({this.errorMessage});
}

class StateLoginChooseRole extends LoginState {
  int chooseRole;
  StateLoginChooseRole({@required this.chooseRole});
}
