import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/film_repository.dart';

part 'future_film_event.dart';
part 'future_film_state.dart';

class FutureFilmBloc extends Bloc<FutureFilmEvent, FutureFilmState> {
  FutureFilmBloc() : super(SuccessGetDataFutureFilmState(<Film>[Film(), Film(), Film()]));

  final FilmRepository _filmRepository = FilmRepository();

  @override
  Stream<FutureFilmState> mapEventToState(
    FutureFilmEvent event,
  ) async* {
    if (event is GetDataFutureFilmEvent) {
      try {
        final List<Film> filmList = await _filmRepository.getFutureFilm();
        yield SuccessGetDataFutureFilmState(filmList);
      } on APIException catch(e) {
        yield FailGetDataFutureFilmState(e.message());
      }
    }
    if (event is ClickToDetailFutureFilmEvent) {
      yield NavigateDetailFutureFilmState(event.id);
    }
  }
}
