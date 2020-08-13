import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/url.dart';
import 'package:ncckios/model/entity.dart';

class FilmRepository {
  
  Future<List<Session>> getSchedule(int filmId,String projectTime) async {
    final AVResponse response = await callPOST(
         path: '${URL.filmSchedule}?Filmid=$filmId&ProjectTime=$projectTime',body: <String,dynamic>{},);
    if (response.isOK) {
      final List<Session> sessionList =<Session>[];
      response.response.forEach((final dynamic itemJson) {
        final Session session = Session.fromJson(itemJson as Map<String,dynamic>);
        sessionList.add(session);
        print('Hello Session ${sessionList.first.languageCode}');
      });
      return sessionList;
    }
    else {
      throw APIException(response);
    }
  }
  
  Future<List<Film>> getFilmList() async {
    final AVResponse result = await callGET(URL.getFilm);
    final List<NextDay> nextDayList = <NextDay>[];
    final List<Film> listFilm = <Film>[];
    if (result.isOK) {
      print(result.response);
      result.response[Constant.nextDay].forEach((final dynamic itemJson) {
        final NextDay nextDay = NextDay.fromJson(
            itemJson as Map<String, dynamic>);
        nextDayList.add(nextDay);
        itemJson[Constant.listFilm].forEach((final dynamic itemJsonFilm) {
          final Film film = Film.fromJson(
              itemJsonFilm as Map<String, dynamic>);

          listFilm.add(film);

        });

      });

      return listFilm;
    } else {
      throw APIException(result);
    }
  }
}

