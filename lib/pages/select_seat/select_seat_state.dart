part of 'select_seat_bloc.dart';

@immutable
abstract class SelectSeatState {}

class SelectSeatInitial extends SelectSeatState {}

class LoadSeatDataSelectSeatState extends SelectSeatState {}

class ReceiveSeatDataSelectSeatState extends SelectSeatState {
  ReceiveSeatDataSelectSeatState(this.seatList, this.totalPrice, this.chosenList);

  final List<Seat> seatList;
  final double totalPrice;
  final List<Seat> chosenList;
}

class FailToReceiveSeatDataSelectSeatState extends SelectSeatState {
  FailToReceiveSeatDataSelectSeatState(this.errorMessage);

  final String errorMessage;
}

class UpdateSeatDataSelectSeatState extends SelectSeatState {
  UpdateSeatDataSelectSeatState(this.totalPrice, this.chosenList);

  final double totalPrice;
  final List<Seat> chosenList;
}
