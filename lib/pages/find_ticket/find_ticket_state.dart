part of 'find_ticket_bloc.dart';

@immutable
abstract class FindTicketState {}

class FindTicketInitial extends FindTicketState {}

class GetTicketSuccessFindTicketState extends FindTicketState {
  GetTicketSuccessFindTicketState(this.orderInfo);

  final OrderInfo orderInfo;
}

class GetTicketFailFindTicketState extends FindTicketState {
  GetTicketFailFindTicketState(this.error);

  final String error;
}

class ShowLoadingFindTicketState extends FindTicketState{}
