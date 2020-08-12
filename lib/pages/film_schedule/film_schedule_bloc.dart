import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/film_repository.dart';

part 'film_schedule_event.dart';
part 'film_schedule_state.dart';

class FilmScheduleBloc extends Bloc<FilmScheduleEvent, FilmScheduleState> {
  FilmScheduleBloc() : super(FilmScheduleInitial());
  FilmRepository filmRepository = FilmRepository();
  @override
  Stream<FilmScheduleState> mapEventToState(
    FilmScheduleEvent event,
  ) async* {
    if (event is FilmScheduleEventGetTime){
      try {
        yield FilmScheduleStateLoading();
        final List<Session> sessionList = await filmRepository.getSchedule(
            event.filmId, event.projectTime);
//        yield FilmScheduleStateDismissLoading();
        if(sessionList.isNotEmpty) {
          yield FilmScheduleStateGetTime(sessionList);
        }
        else{
          yield FilmScheduleStateEmpty();
        }
      }
      on APIException catch(e){
//        yield FilmScheduleStateDismissLoading();
        yield FilmScheduleStateFail(e.message());
      }
    }
    else if(event is FilmScheduleEventClickTimeBox){
      yield FilmScheduleStateToSelectSeatPage();
    }
  }
}
