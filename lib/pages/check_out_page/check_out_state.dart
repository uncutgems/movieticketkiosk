part of 'check_out_bloc.dart';

@immutable
abstract class CheckOutState {}
class CheckOutInitial extends CheckOutState {}
class CheckOutStateQR extends CheckOutState{
  CheckOutStateQR(this.order);
  final Order order;
}
class CheckOutStateTimeOut extends CheckOutState{}
//class CheckOutDismissLoadingState extends CheckOutState{}
//class CheckOutStateShowQR extends CheckOutState{}