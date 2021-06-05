part of 'navbar_bloc.dart';

@immutable
abstract class NavbarState {
  const NavbarState();
}

class NavbarStateLoadingGetRole extends NavbarState {}

class NavbarStateSuccessGetRole extends NavbarState {
  bool isAdmin;
  Widget page;
  NavbarStateSuccessGetRole({@required this.isAdmin, Widget this.page});
}

class NavbarStateLoadDashboard extends NavbarState {}

class NavbarStateLoadAntrean extends NavbarState {}

class NavbarStateLoadAntreanSementara extends NavbarState {}

class NavbarStateLoadTambahAntrean extends NavbarState {}

class NavbarStateLoadPoliklinik extends NavbarState {}

class NavbarStateLoadRiwayat extends NavbarState {}

class NavbarStateLoadAkunPerawat extends NavbarState {}
