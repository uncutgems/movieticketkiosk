
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/url.dart';
import 'package:ncckios/model/entity.dart';

class FilmRepository{
  Future<List<Session>> getSchedule(int filmId,String projectTime) async {
    final AVResponse response = await callPOST(
         path: '${URL.filmSchedule}?Filmid=$filmId&ProjectTime=$projectTime',body: <String,dynamic>{},);
    if (response.isOK) {
      final List<Session> sessionList =<Session>[];
      response.response.forEach((final dynamic itemJson) {
        final Session session = Session.fromJson(itemJson as Map<String,dynamic>);
        sessionList.add(session);
        print('Hello Session ${sessionList.first.id}');
      });

      return sessionList;
    }
    else {
      throw APIException(response);
    }
  }
}