import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/repository/seat_repository.dart';

import '../../base/api_handler.dart';
import '../../model/entity.dart';

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
        final List<Seat> seatList = await seatRepository.getSeat(event.planId);
        yield ReceiveSeatDataSelectSeatState(
            seatList, event.totalPrice, event.chosenSeatList);
      } on APIException catch (error) {
        yield FailToReceiveSeatDataSelectSeatState(error.message());
      }
    } else if (event is UpdateSeatDataSelectSeatEvent) {
      yield ReceiveSeatDataSelectSeatState(
          event.seatList, event.totalPrice, event.chosenSeatList);
    } else if (event is MoveToNextPageSelectSeatEvent) {
      yield MoveToNextScreenSelectSeatState(event.chosenList, event.session);
    }
  }
}
