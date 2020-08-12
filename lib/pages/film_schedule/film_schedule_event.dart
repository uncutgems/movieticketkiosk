part of 'film_schedule_bloc.dart';

@immutable
abstract class FilmScheduleEvent {}
class FilmScheduleEventGetTime extends FilmScheduleEvent{
  FilmScheduleEventGetTime(this.projectTime, this.filmId);
  final String projectTime;
  final int filmId;
}
class FilmScheduleEventClickTimeBox extends FilmScheduleEvent{}