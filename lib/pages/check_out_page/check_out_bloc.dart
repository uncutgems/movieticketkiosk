import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/order_repository.dart';

part 'check_out_event.dart';

part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc() : super(CheckOutInitial());
  OrderRepository orderRepository = OrderRepository();

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
    }
    // TODO: implement mapEventToState
  }
}
