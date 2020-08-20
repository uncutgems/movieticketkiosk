import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/model/enum.dart';
import 'package:ncckios/repository/order_repository.dart';

part 'check_out_event.dart';

part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc() : super(CheckOutInitial());
  OrderRepository orderRepository = OrderRepository();
  Timer statusTimer;

  @override
  Future<void> close() {
    if (statusTimer != null) {
      statusTimer.cancel();
    }
    return super.close();
  }

  @override
  Stream<CheckOutState> mapEventToState(
    CheckOutEvent event,
  ) async* {
    if (event is CheckOutEventClickButton) {
      final Order order = await orderRepository.createOrder(
        event.customerId,
        event.planScreenId,
        event.seatsF1,
        event.listChairValueF1,
        event.customerFirstName,
        event.customerLastName,
        event.paymentMethodSystemName,
      );
      yield CheckOutStateQR(order);
    } else if (event is CheckOutEventShowTimeOut) {
      yield CheckOutStateTimeOut();
    } else if (event is CheckOutEventCheckPaymentStatus) {
      print('event CheckOutEventCheckPaymentStatus');
      try {
        Future<dynamic>.delayed(const Duration(minutes: 5), () {
          if (statusTimer != null) {
            statusTimer.cancel();
            print('stop');
          }
        });
        statusTimer =
            Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
          if (statusTimer.isActive) {
            final OrderStatus orderStatus =
                await orderRepository.checkOrder(event.orderId);
            print('Coders $orderStatus.code');
            add(PaymentStatusChangeCheckOutEvent(orderStatus));
          }
        });
      } on APIException catch (error) {
        statusTimer.cancel();
        yield CheckOutStateTimeOut();
      }
    } else if (event is PaymentStatusChangeCheckOutEvent) {
      if (event.status.code == PaymentStatus.success) {
        statusTimer.cancel();
        yield CheckOutStateSuccess();
      }
    }
  }
}
