part of 'select_seat_bloc.dart';

@immutable
abstract class SelectSeatEvent {}

class GetSeatDataSelectSeatEvent extends SelectSeatEvent {
  GetSeatDataSelectSeatEvent(this.planId, this.totalPrice, this.chosenSeatList);

  final int planId;
  final double totalPrice;
  final List<Seat> chosenSeatList;
}


class UpdateSeatDataSelectSeatEvent extends SelectSeatEvent {
  UpdateSeatDataSelectSeatEvent(this.seatList,this.totalPrice, this.chosenSeatList);
  final List<Seat> seatList;
  final double totalPrice;
  final List<Seat> chosenSeatList;
}
