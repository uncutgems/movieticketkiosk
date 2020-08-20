import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/order_repository.dart';

part 'qr_event.dart';

part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc() : super(QrStateLoading());
  OrderRepository orderRepository = OrderRepository();

  @override
  Stream<QrState> mapEventToState(
    QrEvent event,
  ) async* {
    if (event is QREventCreateQrOrder) {
      try {
        yield QrStateLoading();
        final QRObject qrObject = await orderRepository.createQrOrder(event.orderId);
        yield QrStateShowData(qrObject.data);
      } on APIException {
        yield QrStateFail();
      }
    }
  }
}
