import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ncckios/model/entity.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialHomeState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {

  }
}
