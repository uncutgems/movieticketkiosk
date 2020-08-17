part of 'find_ticket_bloc.dart';

@immutable
abstract class FindTicketState {}

class FindTicketInitial extends FindTicketState {}
class GetTicketSuccessFindTicketState extends FindTicketState {

}
class GetTicketFailFindTicketState extends FindTicketState {}
