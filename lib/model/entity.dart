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
  final Map<String, dynamic> response; // data body response
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
  Film({
    this.id,
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
  });

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
    );
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
        (bannerUrl == null || identical(bannerUrl, this.bannerUrl))) {
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
    };
  }
}

class NextDay {
  NextDay({this.location, this.day, this.listFilm});

  factory NextDay.fromJson(final Map<String, dynamic> json) {
    return NextDay(
      location: getString(Constant.location, json),
      day: getString(Constant.day, json),
    );
  }

  final String location;
  final String day;
  final List<Film> listFilm;
}
