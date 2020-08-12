part of 'film_schedule_bloc.dart';

@immutable
abstract class FilmScheduleState {}

class FilmScheduleInitial extends FilmScheduleState {}
class FilmScheduleStateGetTime extends FilmScheduleState{
  FilmScheduleStateGetTime(this.sessionList);
  final List<Session> sessionList;
}
class FilmScheduleStateLoading extends FilmScheduleState{}
class FilmScheduleStateFail extends FilmScheduleState{
  FilmScheduleStateFail(this.errorMess);
  final String errorMess;
}
class FilmScheduleStateEmpty extends FilmScheduleState{}
class FilmScheduleStateToSelectSeatPage extends FilmScheduleState{}
