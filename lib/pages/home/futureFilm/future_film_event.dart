part of 'future_film_bloc.dart';

@immutable
abstract class FutureFilmEvent {}

class GetDataFutureFilmEvent extends FutureFilmEvent {}

class ClickToDetailFutureFilmEvent extends FutureFilmEvent {
  ClickToDetailFutureFilmEvent(this.id);
  final int id;

}
