part of 'qr_bloc.dart';

@immutable
abstract class QrEvent {}
class QREventCreateQrOrder extends QrEvent{
  QREventCreateQrOrder(this.orderId);
  final int orderId;

}
