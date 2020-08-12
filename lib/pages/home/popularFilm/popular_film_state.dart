part of 'popular_film_bloc.dart';

@immutable
abstract class PopularFilmState {}

class InitialPopularFilmState extends PopularFilmState {}

class SuccessGetDataPopularFilmState extends PopularFilmState {
  SuccessGetDataPopularFilmState(this.filmList, this.index);

  final int index;
  final List<Film> filmList;
}

class FailGetDataPopularFilmState extends PopularFilmState {
  FailGetDataPopularFilmState(this.error);
  final String error;

}

class PageChangedPopularFilmState extends PopularFilmState {
  PageChangedPopularFilmState( this.filmList);
  final List<Film> filmList;
}