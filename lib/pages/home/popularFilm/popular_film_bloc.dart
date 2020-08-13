import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/film_repository.dart';

part 'popular_film_event.dart';
part 'popular_film_state.dart';

final FilmRepository _filmRepository = FilmRepository();

class PopularFilmBloc extends Bloc<PopularFilmEvent, PopularFilmState> {
  PopularFilmBloc() : super(SuccessGetDataPopularFilmState(<Film>[Film()], 0));

  @override
  Stream<PopularFilmState> mapEventToState(
    PopularFilmEvent event,
  ) async* {
    if (event is GetDataPopularFilmEvent) {
      try {
        final List<Film> filmList = await _filmRepository.getFilmList();
        yield SuccessGetDataPopularFilmState(filmList, 0);
      } on APIException catch(e) {
        yield FailGetDataPopularFilmState(e.message());
      }
    }
    if (event is ChangedPagePopularFilmEvent) {
      yield SuccessGetDataPopularFilmState(event.listFilm, event.index);
    }
    if (event is ClickToDetailPopularFilmEvent) {
      yield NavigateDetailPopularFilmState(event.id);
    }
  }
}
