import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/repository/film_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

final FilmRepository _filmRepository = FilmRepository();

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialHomeState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetDataHomeEvent) {
      try {
        yield HomeInitialHomeState();
        final List<Film> filmList = await _filmRepository.getFilmList();
        yield SuccessGetDataHomeState(filmList);
      } on APIException catch(e) {
        yield FailGetDataHomeState(e.message());
      }
    }
  }
}
