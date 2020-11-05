import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/film_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

final FilmRepository _filmRepository = FilmRepository();

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(SuccessGetDataDetailState(Film()));

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is GetDataDetailEvent) {
      try {
        yield LoadingDataDetailState();
        final Film film = await _filmRepository.getDetailFilm(event.id);
        yield SuccessGetDataDetailState(film);
      } on APIException catch(e) {
        yield FailGetDataDetailState(e.message());
      }
    }
  }
}
