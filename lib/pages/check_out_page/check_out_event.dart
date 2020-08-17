part of 'check_out_bloc.dart';

@immutable
abstract class CheckOutEvent {}
class CheckOutEventClickButton extends CheckOutEvent{
  CheckOutEventClickButton({this.customerId, this.planScreenId, this.seatsF1, this.listChairValueF1, this.customerFirstName, this.customerLastName, this.paymentMethodSystemName});
  final int customerId;
  final int planScreenId;
  final String seatsF1;
  final String listChairValueF1;
  final String customerFirstName;
  final String customerLastName;
  final String paymentMethodSystemName;
}
class CheckOutEventShowTimeOut extends CheckOutEvent{}
class CheckOutEventCheckPaymentStatus extends CheckOutEvent{
  CheckOutEventCheckPaymentStatus(this.orderId);
  final int orderId;
}