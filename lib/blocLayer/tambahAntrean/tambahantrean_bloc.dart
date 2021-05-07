import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tambahantrean_event.dart';
part 'tambahantrean_state.dart';

class TambahantreanBloc extends Bloc<TambahantreanEvent, TambahantreanState> {
  TambahantreanBloc() : super(TambahantreanInitial());

  @override
  Stream<TambahantreanState> mapEventToState(
    TambahantreanEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
