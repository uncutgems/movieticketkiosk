part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialHomeState extends HomeState {}

class SuccessGetDataHomeState extends HomeState {
  SuccessGetDataHomeState(this.listFilm);

  final List<Film> listFilm;
}

class FailGetDataHomeState extends HomeState {
  FailGetDataHomeState(this.error);

  final String error;
}


