part of 'qr_bloc.dart';

@immutable
abstract class QrState {}
class QrStateLoading extends QrState {}
class QrStateShowData extends QrState {
  QrStateShowData(this.data);
  final String data;
}
class QrStateFail extends QrState{}
