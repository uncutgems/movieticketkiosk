import 'dart:math';

import 'package:ncckios/model/enum.dart';

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

      final int maximumColumn = findMaxColumn(seatList) + 1;
      int rowIndex = 0;

      final int insertColumn = seatList.first.column;
      for (int i = 0; i < seatList.length; i++) {
        if (seatList[i].column == insertColumn) {
          seatList.insert(
              i,
              Seat(
                  type: SeatType.alphabetSeat,
                  rows: rowIndex,
                  column: insertColumn));
          rowIndex++;
          i++;
        }
      }

      final bool check = seatList.first.column > seatList.last.column;
      for (int i = 0; i < maximumColumn + 1; i++) {
        seatList.insert(
            i,
            Seat(
                type: SeatType.numberTheSeat,
                column: i,
                rows: 0,
                code: (check ? maximumColumn - i + 1 : i).toString()));
        //columnIndex--;
      }



      print(maximumColumn.toString());

      return seatList;
    } else {
      throw APIException(response);
    }
  }
}

int findMaxColumn(List<Seat> myList) {
  int maxColumnNumber;
  if (myList != null && myList.isNotEmpty) {
    maxColumnNumber = myList.map<int>((Seat e) => e.column ?? 0).reduce(max);
  }
  return maxColumnNumber;
}
