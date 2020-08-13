part of 'popular_film_bloc.dart';

@immutable
abstract class PopularFilmEvent {}

class GetDataPopularFilmEvent extends PopularFilmEvent {}

class ChangedPagePopularFilmEvent extends PopularFilmEvent {
  ChangedPagePopularFilmEvent(this.index, this.listFilm);
  final int index;
  final List<Film> listFilm;

}

class ClickToDetailPopularFilmEvent extends PopularFilmEvent {
  ClickToDetailPopularFilmEvent(this.id);
  final int id;

}