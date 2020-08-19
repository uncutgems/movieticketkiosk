import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/order_repository.dart';

part 'find_ticket_event.dart';

part 'find_ticket_state.dart';

final OrderRepository _orderRepository = OrderRepository();

class FindTicketBloc extends Bloc<FindTicketEvent, FindTicketState> {
  FindTicketBloc() : super(FindTicketInitial());

  @override
  Stream<FindTicketState> mapEventToState(
    FindTicketEvent event,
  ) async* {
    if (event is CLickFindTicketEvent) {
      try {
        yield GetTicketSuccessFindTicketState(OrderInfo());
        final OrderInfo orderInfo =
            await _orderRepository.ticketDetail(event.id);
        yield GetTicketSuccessFindTicketState(orderInfo);
      } on APIException catch (e) {
        yield GetTicketFailFindTicketState(e.message());
      }
    }
  }
}
