import '../base/api_handler.dart';
import '../base/constant.dart';
import '../base/url.dart';
import '../model/entity.dart';

class SeatRepository {
  Future<List<Seat>> getSeat(int planId) async {
    final List<Seat> seatList = <Seat>[];

    final String _url = '${URL.getSeatURL}?${Constant.PlanId}=$planId';
    final AVResponse response = await callGET(_url);

    if (response.isOK) {
      print('Get Seat List successfully');
      print('honaa+ $response');

      response.response.forEach((final dynamic itemJson) {
        itemJson.forEach((final dynamic seatJson) {
          final Seat seatObject =
              Seat.fromJson(seatJson as Map<String, dynamic>);
          seatList.add(seatObject);
          print('this is the small list $seatJson');
        });
      });

      return seatList;
    } else {
      throw APIException(response);
    }
  }
}
