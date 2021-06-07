part of 'navbar_bloc.dart';

@immutable
abstract class NavbarEvent {
  const NavbarEvent();
}

class NavbarEventGetRole extends NavbarEvent {}

class NavbarEventLoadDashboard extends NavbarEvent {}

class NavbarEventLoadAntrean extends NavbarEvent {}

class NavbarEventLoadAntreanSementara extends NavbarEvent {}

class NavbarEventLoadAntreanSelesai extends NavbarEvent {}

class NavbarEventLoadTambahAntrean extends NavbarEvent {}

class NavbarEventLoadPoliklinik extends NavbarEvent {}

class NavbarEventLoadRiwayat extends NavbarEvent {}

class NavbarEventLoadAkunPerawat extends NavbarEvent {}