
import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/url.dart';
import 'package:ncckios/model/entity.dart';

class FilmRepository{
  Future<List<Session>> getSchedule() async {
    final AVResponse response = await callGET(

        '${URL.baseURL}${URL.filmSchedule}/?ProjectDate=08%2F10%2F2020');
    if (response.isOK) {
      final List<Session> sessionList =<Session>[];
      print('Hello Session');
      response.response[Constant.lstPlan].forEach((final dynamic itemJson) {
        Session session = Session.f
        
      });





      return sessionList;
    }
    else {
      throw APIException(response);
    }
  }
}