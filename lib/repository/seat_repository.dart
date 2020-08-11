import '../base/api_handler.dart';
import '../base/constant.dart';
import '../base/constant.dart';
import '../base/constant.dart';
import '../base/url.dart';
import '../model/entity.dart';
import '../model/entity.dart';
import '../model/entity.dart';

class SeatRepository {
  Future<void> getSeat(int planId) async {
    final List<Seat> smallSeatList = <Seat>[];
    final List<List<Seat>> bigList = <List<Seat>>[];
    final String _url = '${URL.getSeatURL}?${Constant.PlanId}=$planId';
    final AVResponse response = await callGET(_url);

    if (response.isOK) {
      print('Get Seat List successfully');
      print('honaaaaaaaaaaaaaaaaaaaaaa+ $response');

      response.response.forEach((final dynamic itemJson) {
        itemJson.forEach((final dynamic seatJson) {
          final Seat seatObject =
              Seat.fromJson(seatJson as Map<String, dynamic>);
          smallSeatList.add(seatObject);
        });
        bigList.add(smallSeatList);
      });
    } else {
      throw APIException(response);
    }
  }
}
