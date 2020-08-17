import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'find_ticket_event.dart';
part 'find_ticket_state.dart';

class FindTicketBloc extends Bloc<FindTicketEvent, FindTicketState> {
  FindTicketBloc() : super(FindTicketInitial());

  @override
  Stream<FindTicketState> mapEventToState(
    FindTicketEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
