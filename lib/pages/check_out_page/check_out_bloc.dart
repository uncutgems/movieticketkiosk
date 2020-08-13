import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc() : super(CheckOutInitial());

  @override
  Stream<CheckOutState> mapEventToState(
    CheckOutEvent event,
  ) async* {
    if (event is CheckOutEventClickButton){
      yield CheckOutStateQR();
    }
    // TODO: implement mapEventToState
  }
}
