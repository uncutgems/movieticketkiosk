part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class SuccessGetDataDetailState extends DetailState{
  SuccessGetDataDetailState(this.film);
  final Film film;

}

class FailGetDataDetailState extends DetailState {
  FailGetDataDetailState(this.error);
  final String error;

}