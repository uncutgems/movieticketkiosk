import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/repository/seat_repository.dart';

import '../../base/api_handler.dart';

part 'select_seat_event.dart';

part 'select_seat_state.dart';

class SelectSeatBloc extends Bloc<SelectSeatEvent, SelectSeatState> {
  SelectSeatBloc() : super(SelectSeatInitial());
  SeatRepository seatRepository = SeatRepository();

  @override
  Stream<SelectSeatState> mapEventToState(
    SelectSeatEvent event,
  ) async* {
    if (event is GetSeatDataSelectSeatEvent) {
      try {
        yield LoadSeatDataSelectSeatState();
        await seatRepository.getSeat(event.planId);
        yield ReceiveSeatDataSelectSeatState();
      } on APIException catch (e) {
        yield FailToReceiveSeatDataSelectSeatState();
      }
    }
  }
}
