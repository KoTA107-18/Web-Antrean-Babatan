part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class EventIsiUsername extends LoginEvent {
  final String username;
  EventIsiUsername({@required this.username});
}

class EventIsiPassword extends LoginEvent {
  final String password;
  EventIsiPassword({@required this.password});
}

class EventTapLogin extends LoginEvent {}
