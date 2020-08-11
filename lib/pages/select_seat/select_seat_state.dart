part of 'select_seat_bloc.dart';

@immutable
abstract class SelectSeatState {}

class SelectSeatInitial extends SelectSeatState {}

class LoadSeatDataSelectSeatState extends SelectSeatState {}

class ReceiveSeatDataSelectSeatState extends SelectSeatState {
  ReceiveSeatDataSelectSeatState(this.seatList);

  final List<Seat> seatList;
}

class FailToReceiveSeatDataSelectSeatState extends SelectSeatState {}
