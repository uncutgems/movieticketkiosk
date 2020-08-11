part of 'film_schedule_bloc.dart';

@immutable
abstract class FilmScheduleState {}

class FilmScheduleInitial extends FilmScheduleState {}
class FilmScheduleStateGetTime extends FilmScheduleState{
  FilmScheduleStateGetTime(this.sessionList);
  final List<Session> sessionList;
}
class FilmScheduleStateLoading extends FilmScheduleState{}
class FilmScheduleStateDismissLoading extends FilmScheduleState{}