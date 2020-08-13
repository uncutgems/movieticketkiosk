part of 'check_out_bloc.dart';

@immutable
abstract class CheckOutState {}
class CheckOutInitial extends CheckOutState {}
class CheckOutStateQR extends CheckOutState{}