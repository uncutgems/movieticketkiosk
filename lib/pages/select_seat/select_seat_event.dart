part of 'select_seat_bloc.dart';

@immutable
abstract class SelectSeatEvent {}

class GetSeatDataSelectSeatEvent extends SelectSeatEvent {
  GetSeatDataSelectSeatEvent(this.planId);

  final int planId;
}


