part of 'navbar_bloc.dart';

@immutable
abstract class NavbarState {
  const NavbarState();
}

class NavbarStateLoadingGetRole extends NavbarState {}

class NavbarStateSuccessGetRole extends NavbarState {
  bool isAdmin;
  String title;
  Widget page;
  NavbarStateSuccessGetRole(
      {@required this.isAdmin, String this.title, Widget this.page});
}
