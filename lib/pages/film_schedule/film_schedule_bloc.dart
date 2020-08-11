import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
      await filmRepository.getSchedule();
      yield FilmScheduleStateGetTime();
    }
  }
}
