part of 'find_ticket_bloc.dart';

@immutable
abstract class FindTicketEvent {}

class CLickFindTicketEvent extends FindTicketEvent{
  CLickFindTicketEvent(this.id);
  final String id;
}