import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'akun_perawat_event.dart';
part 'akun_perawat_state.dart';

class AkunPerawatBloc extends Bloc<AkunPerawatEvent, AkunPerawatState> {
  AkunPerawatBloc() : super(AkunPerawatInitial());

  @override
  Stream<AkunPerawatState> mapEventToState(
    AkunPerawatEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
