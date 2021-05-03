part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class EventTapLogin extends LoginEvent {
  final String username, password;
  EventTapLogin({@required this.username, @required this.password});
}
