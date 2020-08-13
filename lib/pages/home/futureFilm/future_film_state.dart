part of 'future_film_bloc.dart';

@immutable
abstract class FutureFilmState {}

class InitialFutureFilmState extends FutureFilmState {}
class SuccessGetDataFutureFilmState extends FutureFilmState {
  SuccessGetDataFutureFilmState(this.listFilm);
  final List<Film> listFilm;

}
class FailGetDataFutureFilmState extends FutureFilmState {
  FailGetDataFutureFilmState(this.error);
  final String error;

}

class NavigateDetailFutureFilmState extends FutureFilmState {
  NavigateDetailFutureFilmState(this.id);

  final int id;
}
