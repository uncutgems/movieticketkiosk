import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ncckios/base/constant.dart';

import '../base/constant.dart';

/// Các hàm lấy dữ liệu - Tools
/// Lấy dữ liệu dạng string từ map mặc định ''
String getString(String key, Map<String, dynamic> data) {
  String result = '';
  if (data == null) {
    result = '';
  } else if (data[key] == null) {
    result = '';
  } else if (!data.containsKey(key)) {
    result = '';
  } else {
    result = data[key].toString();
  }
  return result;
}

///Lấy dữ liệu int từ map mặc định 0
int getInt(String key, Map<String, dynamic> data) {
  int result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = int.parse(data[key].toString());
  }
  return result;
}

/// Lấy dữ liệu double từ map mặc định 0
double getDouble(String key, Map<String, dynamic> data) {
  double result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = double.parse(data[key].toString());
  }
  return result;
}

/// lấy dữ liệu bool từ map mặc định false
bool getBool(String key, Map<String, dynamic> data) {
  bool result = false;
  if (data == null) {
    result = false;
  } else if (data[key] == null) {
    result = false;
  } else if (!data.containsKey(key)) {
    result = false;
  } else {
    result = data[key] as bool;
  }
  return result;
}

/// Lấy list double entity
List<double> getListDouble(String key, Map<String, dynamic> data) {
  final List<double> result = <double>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as double);
  });
  return result;
}

/// Get list int entity
List<int> getListInt(String key, Map<String, dynamic> data) {
  final List<int> result = <int>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as int);
  });
  return result;
}

/// Get list String entity
List<String> getListString(String key, Map<String, dynamic> data) {
  final List<String> result = <String>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as String);
  });
  return result;
}

/// List film
List<Film> parseListFilm(List<dynamic> data) {
  final List<Film> films = <Film>[];
  if (data == null) {
    return films;
  }
  for (final dynamic itemJson in data) {
    films.add(Film.fromJson(itemJson as Map<String, dynamic>));
  }
  return films;
}

@JsonSerializable(nullable: false)
class AVResponse {
  AVResponse({
    @required this.isOK,
    @required this.code,
    @required this.response,
    this.message,
  }); // case not ok show message

  final bool isOK; // check Response is OK
  final int code; // status code
  final dynamic response; // data body response
  final String message;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.ok: isOK,
      Constant.code: code,
      Constant.response: response,
      Constant.message: message,
    };
  }
}

@JsonSerializable(nullable: false)
class Film {
  Film(
      {this.id,
      this.filmNameEn,
      this.filmName,
      this.duration,
      this.director,
      this.actors,
      this.introduction,
      this.versionCode,
      this.countryName,
      this.languageCode,
      this.premieredDay,
      this.description,
      this.statusCode,
      this.videoUrl,
      this.sellOnline,
      this.ageAboveShow,
      this.imageUrl,
      this.bannerUrl,
      this.category});

  factory Film.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return Film();
    }
    return Film(
        id: getInt(Constant.id, data),
        filmNameEn: getString(Constant.filmNameEn, data),
        filmName: getString(Constant.filmName, data),
        duration: getInt(Constant.duration, data),
        director: getString(Constant.director, data),
        actors: getString(Constant.actors, data),
        introduction: getString(Constant.introduction, data),
        versionCode: getString(Constant.versionCode, data),
        countryName: getString(Constant.countryName, data),
        languageCode: getString(Constant.languageCode, data),
        premieredDay: getString(Constant.premieredDay, data),
        description: getString(Constant.description, data),
        statusCode: getString(Constant.statusCode, data),
        videoUrl: getString(Constant.videoUrl, data),
        sellOnline: getBool(Constant.sellOnline, data),
        ageAboveShow: getString(Constant.ageAboveShow, data),
        imageUrl: getString(Constant.imageUrl, data),
        bannerUrl: getString(Constant.bannerUrl, data),
        category: getString(Constant.category, data));
  }

  final int id;
  final String filmNameEn;
  final String filmName;
  final int duration;
  final String director;
  final String actors;
  final String introduction;
  final String versionCode;
  final String countryName;
  final String languageCode;
  final String premieredDay;
  final String description;
  final String statusCode;
  final String videoUrl;
  final bool sellOnline;
  final String ageAboveShow;
  final String imageUrl;
  final String bannerUrl;
  final String category;

  Film copyWith({
    int id,
    String filmNameEn,
    String filmName,
    int duration,
    String director,
    String actors,
    String introduction,
    String versionCode,
    String countryName,
    String languageCode,
    String premieredDay,
    String description,
    String statusCode,
    String videoUrl,
    bool sellOnline,
    String ageAboveShow,
    String imageUrl,
    String bannerUrl,
    String category,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (filmNameEn == null || identical(filmNameEn, this.filmNameEn)) &&
        (filmName == null || identical(filmName, this.filmName)) &&
        (duration == null || identical(duration, this.duration)) &&
        (director == null || identical(director, this.director)) &&
        (actors == null || identical(actors, this.actors)) &&
        (introduction == null || identical(introduction, this.introduction)) &&
        (versionCode == null || identical(versionCode, this.versionCode)) &&
        (countryName == null || identical(countryName, this.countryName)) &&
        (languageCode == null || identical(languageCode, this.languageCode)) &&
        (premieredDay == null || identical(premieredDay, this.premieredDay)) &&
        (description == null || identical(description, this.description)) &&
        (statusCode == null || identical(statusCode, this.statusCode)) &&
        (videoUrl == null || identical(videoUrl, this.videoUrl)) &&
        (sellOnline == null || identical(sellOnline, this.sellOnline)) &&
        (ageAboveShow == null || identical(ageAboveShow, this.ageAboveShow)) &&
        (imageUrl == null || identical(imageUrl, this.imageUrl)) &&
        (bannerUrl == null || identical(bannerUrl, this.bannerUrl)) &&
        (category == null || identical(category, this.category))) {
      return this;
    }

    return Film(
      id: id ?? this.id,
      filmNameEn: filmNameEn ?? this.filmNameEn,
      filmName: filmName ?? this.filmName,
      duration: duration ?? this.duration,
      director: director ?? this.director,
      actors: actors ?? this.actors,
      introduction: introduction ?? this.introduction,
      versionCode: versionCode ?? this.versionCode,
      countryName: countryName ?? this.countryName,
      languageCode: languageCode ?? this.languageCode,
      premieredDay: premieredDay ?? this.premieredDay,
      description: description ?? this.description,
      statusCode: statusCode ?? this.statusCode,
      videoUrl: videoUrl ?? this.videoUrl,
      sellOnline: sellOnline ?? this.sellOnline,
      ageAboveShow: ageAboveShow ?? this.ageAboveShow,
      imageUrl: imageUrl ?? this.imageUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.filmNameEn: filmNameEn,
      Constant.filmName: filmName,
      Constant.duration: duration,
      Constant.director: director,
      Constant.actors: actors,
      Constant.introduction: introduction,
      Constant.versionCode: versionCode,
      Constant.countryName: countryName,
      Constant.languageCode: languageCode,
      Constant.premieredDay: premieredDay,
      Constant.description: description,
      Constant.statusCode: statusCode,
      Constant.videoUrl: videoUrl,
      Constant.sellOnline: sellOnline,
      Constant.ageAboveShow: ageAboveShow,
      Constant.imageUrl: imageUrl,
      Constant.bannerUrl: bannerUrl,
      Constant.category: category,
    };
  }
}

class NextDay {
  NextDay({this.location, this.day, this.listFilm});

  factory NextDay.fromJson(final Map<String, dynamic> json) {
    return NextDay(
      location: getString(Constant.location, json),
      day: getString(Constant.day, json),
      listFilm: parseListFilm(json[Constant.listFilm] as List<dynamic>),
    );
  }

  final String location;
  final String day;
  final List<Film> listFilm;
}

@JsonSerializable(nullable: false)
class Session {
  Session(
      {this.id,
      this.planCinemaId,
      this.projectDate,
      this.projectTime,
      this.filmId,
      this.roomId,
      this.dayPartId,
      this.publishDate,
      this.isOnlineSelling,
      this.priceOfPosition,
      this.priceOfPosition2,
      this.priceOfPosition3,
      this.languageCode,
      this.versionCode,
      this.roomName});

  factory Session.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return Session();
    }

    return Session(
      id: getInt(Constant.id, data),
      planCinemaId: getInt(Constant.planCinemaId, data),
      projectDate: getString(Constant.projectDate, data),
      projectTime: getString(Constant.projectTime, data),
      filmId: getInt(Constant.filmId, data),
      roomId: getInt(Constant.roomId, data),
      dayPartId: getInt(Constant.dayPartId, data),
      publishDate: getString(Constant.publishDate, data),
      isOnlineSelling: getInt(Constant.isOnlineSelling, data),
      priceOfPosition: getString(Constant.priceOfPosition, data),
      priceOfPosition2: getString(Constant.priceOfPosition2, data),
      priceOfPosition3: getString(Constant.priceOfPosition3, data),
      versionCode: getString(Constant.versionCode, data),
      languageCode: getString(Constant.languageCode, data),
      roomName: getString(Constant.roomName, data),
    );
  }

  Session copyWith({
    int id,
    int planCinemaId,
    String projectDate,
    String projectTime,
    int filmId,
    int roomId,
    int dayPartId,
    String publishDate,
    int isOnlineSelling,
    String priceOfPosition,
    String priceOfPosition2,
    String priceOfPosition3,
    String versionCode,
    String languageCode,
    String roomName,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (planCinemaId == null || identical(planCinemaId, this.planCinemaId)) &&
        (projectDate == null || identical(projectDate, this.projectDate)) &&
        (projectTime == null || identical(projectTime, this.projectTime)) &&
        (filmId == null || identical(filmId, this.filmId)) &&
        (roomId == null || identical(roomId, this.roomId)) &&
        (dayPartId == null || identical(dayPartId, this.dayPartId)) &&
        (publishDate == null || identical(publishDate, this.publishDate)) &&
        (isOnlineSelling == null ||
            identical(isOnlineSelling, this.isOnlineSelling)) &&
        (priceOfPosition == null ||
            identical(priceOfPosition, this.priceOfPosition)) &&
        (priceOfPosition2 == null ||
            identical(priceOfPosition2, this.priceOfPosition2)) &&
        (priceOfPosition3 == null ||
            identical(priceOfPosition3, this.priceOfPosition3)) &&
        (versionCode == null || identical(versionCode, this.versionCode)) &&
        (languageCode == null || identical(languageCode, this.languageCode)) &&
        (roomName == null || identical(roomName, this.roomName))) {
      return this;
    }

    return Session(
      id: id ?? this.id,
      planCinemaId: planCinemaId ?? this.planCinemaId,
      projectDate: projectDate ?? this.projectDate,
      projectTime: projectTime ?? this.projectTime,
      filmId: filmId ?? this.filmId,
      roomId: roomId ?? this.roomId,
      dayPartId: dayPartId ?? this.dayPartId,
      publishDate: publishDate ?? this.publishDate,
      isOnlineSelling: isOnlineSelling ?? this.isOnlineSelling,
      priceOfPosition: priceOfPosition ?? this.priceOfPosition,
      priceOfPosition2: priceOfPosition2 ?? this.priceOfPosition2,
      priceOfPosition3: priceOfPosition3 ?? this.priceOfPosition3,
      versionCode: versionCode ?? this.versionCode,
      languageCode: languageCode ?? this.languageCode,
      roomName: roomName ?? this.roomName,
    );
  }

  final int id;
  final int planCinemaId;
  final String projectDate;
  final String projectTime;
  final int filmId;
  final int roomId;
  final int dayPartId;
  final String publishDate;
  final int isOnlineSelling;
  final String priceOfPosition;
  final String priceOfPosition2;
  final String priceOfPosition3;
  final String versionCode;
  final String languageCode;
  final String roomName;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.planCinemaId: planCinemaId,
      Constant.projectDate: projectDate,
      Constant.projectTime: projectTime,
      Constant.filmId: filmId,
      Constant.roomId: roomId,
      Constant.dayPartId: dayPartId,
      Constant.publishDate: publishDate,
      Constant.isOnlineSelling: isOnlineSelling,
      Constant.priceOfPosition: priceOfPosition,
      Constant.priceOfPosition2: priceOfPosition2,
      Constant.priceOfPosition3: priceOfPosition3,
      Constant.versionCode: versionCode,
      Constant.languageCode: languageCode,
      Constant.roomName: roomName,
    };
  }
}

@JsonSerializable(nullable: false)
class Seat {
  Seat({
    this.rows,
    this.column,
    this.seatId,
    this.code,
    this.type,
    this.status,
    this.seatDataId,
    this.price,
    this.seat,
  });

  factory Seat.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return Seat();
    }
    return Seat(
      seatId: getInt(Constant.seatId, data),
      code: getString(Constant.code, data),
      type: getString(Constant.type, data),
      status: getInt(Constant.status, data),
      seatDataId: getInt(Constant.seatDataId, data),
      price: getDouble(Constant.price, data),
      rows: getInt(Constant.rows, data),
      column: getInt(Constant.column, data),
      seat: getString(Constant.seat, data),
    );
  }

  Seat copyWith({
    int seatId,
    String code,
    String type,
    int status,
    int seatDataId,
    double price,
    int column,
    int rows,
    String seat,
  }) {
    if ((seatId == null || identical(seatId, this.seatId)) &&
        (code == null || identical(code, this.code)) &&
        (type == null || identical(type, this.type)) &&
        (status == null || identical(status, this.status)) &&
        (seatDataId == null || identical(seatDataId, this.seatDataId)) &&
        (price == null || identical(price, this.price)) &&
        (column == null || identical(column, this.column)) &&
        (rows == null || identical(rows, this.rows)) &&
        (seat == null || identical(seat, this.seat))) {
      return this;
    }

    return Seat(
      seatId: seatId ?? this.seatId,
      code: code ?? this.code,
      type: type ?? this.type,
      status: status ?? this.status,
      seatDataId: seatDataId ?? this.seatDataId,
      price: price ?? this.price,
      column: column ?? this.column,
      rows: rows ?? this.rows,
      seat: seat ?? this.seat,
    );
  }

  final int seatId;
  final String code;
  final String type;
  final int status;
  final int seatDataId;
  final double price;
  final int column;
  final int rows;
  final String seat;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.seatId: seatDataId,
      Constant.code: code,
      Constant.type: type,
      Constant.status: status,
      Constant.seatDataId: seatDataId,
      Constant.price: price,
      Constant.rows: rows,
      Constant.column: column,
      Constant.seat: seat,
    };
  }
}

@JsonSerializable(nullable: false)
class Ticket {
  Ticket({this.ticketNo});

  factory Ticket.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return Ticket();
    }
    return Ticket(
      ticketNo: getString(Constant.ticketNo, data),
    );
  }

  Ticket copyWith({
    String ticketNo,
  }) {
    if (ticketNo == null || identical(ticketNo, this.ticketNo)) {
      return this;
    }

    return Ticket(
      ticketNo: ticketNo ?? this.ticketNo,
    );
  }

  final String ticketNo;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.ticketNo: ticketNo,
    };
  }
}

@JsonSerializable(nullable: false)
class Order {
  Order({this.orderTotal, this.orderId});

  factory Order.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return Order();
    }
    return Order(
      orderId: getInt(Constant.orderId, data),
      orderTotal: getDouble(Constant.orderTotal, data),
    );
  }

  final int orderId;
  final double orderTotal;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.orderId: orderId,
      Constant.orderTotal: orderTotal,
    };
  }
}

class QRObject {
  QRObject({this.data, this.url, this.idQrCode});

  factory QRObject.fromJson(final Map<String, dynamic> response) {
    if (response == null) {
      return QRObject();
    }
    return QRObject(
        data: getString(Constant.data, response),
        url: getString(Constant.url, response),
        idQrCode: getString(Constant.idQrCode, response));
  }

  final String data;
  final String url;
  final String idQrCode;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.data: data,
      Constant.url: url,
      Constant.idQrCode: idQrCode
    };
  }
}

class OrderStatus {
  OrderStatus({this.barCode, this.code});

  factory OrderStatus.fromJson(final Map<String, dynamic> response) {
    if (response == null) {
      return OrderStatus();
    }
    return OrderStatus(
        barCode: getString(Constant.barCode, response),
        code: getString(Constant.code, response));
  }

  final String barCode;
  final String code;
}

class SessionType {
  SessionType({this.versionCode, this.languageCode, this.sessionList});

  final String versionCode;
  final String languageCode;
  final List<Session> sessionList;
}

class OrderInfo {
  OrderInfo( {
    this.languageCode,
    this.filmName,
    this.versionCode,
    this.customerName,
    this.projectTime,
    this.projectDate,
    this.roomName,
    this.seats,
    this.barCode,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return OrderInfo();
    }
    return OrderInfo(
      filmName: getString(Constant.filmName, json),
      versionCode: getString(Constant.versionCode, json),
      customerName: getString(Constant.customerName, json),
      projectDate: getString(Constant.projectDate, json),
      projectTime: getString(Constant.projectTime, json),
      roomName: getString(Constant.roomName, json),
      seats: getString(Constant.seats, json),
      barCode: getString(Constant.barCode, json),
      languageCode: getString(Constant.languageCode, json),
    );
  }

  Map<String, dynamic>toJson() {
    return <String, dynamic> {
      Constant.filmName: filmName,
      Constant.versionCode: versionCode,
      Constant.customerName: customerName,
      Constant.projectDate: projectDate,
      Constant.projectTime: projectTime,
      Constant.roomName: roomName,
      Constant.seats: seats,
      Constant.barCode: barCode,
      Constant.languageCode: languageCode,
    };

}

  OrderInfo copyWith({
    String filmName,
    String languageCode,
    String versionCode,
    String barCode,
    String customerName,
    String projectTime,
    String projectDate,
    String roomName,
    String seats,
  }) {
    if ((filmName == null || identical(filmName, this.filmName)) &&
        (languageCode == null || identical(languageCode, this.languageCode)) &&
        (versionCode == null || identical(versionCode, this.versionCode)) &&
        (barCode == null || identical(barCode, this.barCode)) &&
        (customerName == null || identical(customerName, this.customerName)) &&
        (projectTime == null || identical(projectTime, this.projectTime)) &&
        (projectDate == null || identical(projectDate, this.projectDate)) &&
        (roomName == null || identical(roomName, this.roomName)) &&
        (seats == null || identical(seats, this.seats))) {
      return this;
    }

    return OrderInfo(
      filmName: filmName ?? this.filmName,
      languageCode: languageCode ?? this.languageCode,
      versionCode: versionCode ?? this.versionCode,
      barCode: barCode ?? this.barCode,
      customerName: customerName ?? this.customerName,
      projectTime: projectTime ?? this.projectTime,
      projectDate: projectDate ?? this.projectDate,
      roomName: roomName ?? this.roomName,
      seats: seats ?? this.seats,
    );
  }

  final String filmName;
  final String languageCode;
  final String versionCode;
  final String barCode;
  final String customerName;
  final String projectTime;
  final String projectDate;
  final String roomName;
  final String seats;
}
