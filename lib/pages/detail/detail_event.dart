part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class GetDataDetailEvent extends DetailEvent{
  GetDataDetailEvent(this.id);
  final int id;

}