import 'dart:async';

import 'package:bloc/bloc.dart';

part 'navbar_event.dart';
class NavbarBloc extends Bloc<NavbarEvent, int> {

  NavbarBloc(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(
    NavbarEvent event,
  ) async* {
    switch (event) {
      case NavbarEvent.tapDashboard:
        yield 0;
        break;
      case NavbarEvent.tapAntrean:
        yield 1;
        break;
      case NavbarEvent.tapAntreanSementara:
        yield 2;
        break;
      case NavbarEvent.tapTambahAntrean:
        yield 3;
        break;
      case NavbarEvent.tapPoliklinik:
        yield 4;
        break;
      case NavbarEvent.tapRiwayatKunjungan:
        yield 5;
        break;
      case NavbarEvent.tapAkunPerawat:
        yield 6;
        break;
    }
  }
}
