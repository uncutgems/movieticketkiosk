import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// chuyển thời gian từ millisecond sang định dạng format
String convertTime(String format, int time, bool isUTC) {
  return DateFormat(format, 'vi').format(DateTime.fromMillisecondsSinceEpoch(time, isUtc: isUTC));
}

int convertNewDayStyleToMillisecond(int time) {
  final String timeString = time.toString();
  final int year = int.parse(timeString.substring(0, 4));
  final int month = int.parse(timeString.substring(4, 6));
  final int day = int.parse(timeString.substring(6, 8));
  return DateTime(year, month, day).millisecondsSinceEpoch;
}

String currencyFormat(int param, String unit) {
  final NumberFormat formatCurrency = NumberFormat();
  final String result = formatCurrency.format(param);
  return result + ' ' + unit;
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: currencyFormat(int.parse(newValue.text.toString().trim()), 'VNĐ'));
  }
}

List<String> source = <String>[
  'À',
  'Á',
  'Â',
  'Ã',
  'È',
  'É',
  'Ê',
  'Ì',
  'Í',
  'Ò',
  'Ó',
  'Ô',
  'Õ',
  'Ù',
  'Ú',
  'Ý',
  'à',
  'á',
  'â',
  'ã',
  'è',
  'é',
  'ê',
  'ì',
  'í',
  'ò',
  'ó',
  'ô',
  'õ',
  'ù',
  'ú',
  'ý',
  'Ă',
  'ă',
  'Đ',
  'đ',
  'Ĩ',
  'ĩ',
  'Ũ',
  'ũ',
  'Ơ',
  'ơ',
  'Ư',
  'ư',
  'Ạ',
  'ạ',
  'Ả',
  'ả',
  'Ấ',
  'ấ',
  'Ầ',
  'ầ',
  'Ẩ',
  'ẩ',
  'Ẫ',
  'ẫ',
  'Ậ',
  'ậ',
  'Ắ',
  'ắ',
  'Ằ',
  'ằ',
  'Ẳ',
  'ẳ',
  'Ẵ',
  'ẵ',
  'Ặ',
  'ặ',
  'Ẹ',
  'ẹ',
  'Ẻ',
  'ẻ',
  'Ẽ',
  'ẽ',
  'Ế',
  'ế',
  'Ề',
  'ề',
  'Ể',
  'ể',
  'Ễ',
  'ễ',
  'Ệ',
  'ệ',
  'Ỉ',
  'ỉ',
  'Ị',
  'ị',
  'Ọ',
  'ọ',
  'Ỏ',
  'ỏ',
  'Ố',
  'ố',
  'Ồ',
  'ồ',
  'Ổ',
  'ổ',
  'Ỗ',
  'ỗ',
  'Ộ',
  'ộ',
  'Ớ',
  'ớ',
  'Ờ',
  'ờ',
  'Ở',
  'ở',
  'Ỡ',
  'ỡ',
  'Ợ',
  'ợ',
  'Ụ',
  'ụ',
  'Ủ',
  'ủ',
  'Ứ',
  'ứ',
  'Ừ',
  'ừ',
  'Ử',
  'ử',
  'Ữ',
  'ữ',
  'Ự',
  'ự'
];
List<String> destination = <String>[
  'A',
  'A',
  'A',
  'A',
  'E',
  'E',
  'E',
  'I',
  'I',
  'O',
  'O',
  'O',
  'O',
  'U',
  'U',
  'Y',
  'a',
  'a',
  'a',
  'a',
  'e',
  'e',
  'e',
  'i',
  'i',
  'o',
  'o',
  'o',
  'o',
  'u',
  'u',
  'y',
  'A',
  'a',
  'D',
  'd',
  'I',
  'i',
  'U',
  'u',
  'O',
  'o',
  'U',
  'u',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'A',
  'a',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'E',
  'e',
  'I',
  'i',
  'I',
  'i',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'O',
  'o',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u',
  'U',
  'u'
];

String convertAccent(String text) {
  String result = '';
  for (int i = 0; i < text.length; i++) {
    final int index = source.indexOf(text[i]);
    if (index != -1) {
      result += destination[index];
    } else {
      result += text[i];
    }
  }
  return result;
}
String convertDateToInput(DateTime date) {
  final String result = DateFormat('MM%2Fdd%2Fyyyy', 'vi').format(date);
  return result;
}
String convertTimeToDisplay(String date){
  final DateTime dateTime = DateTime.parse(date);
  final String result = DateFormat('hh:mm - dd/MM/yyyy').format(dateTime);
  return result;
}


String convertLanguageCode (String code) {
  switch (code) {
    case 'PDV':
      return 'Phụ đề Việt';
    case 'LTV':
      return 'Lồng tiếng Việt';
    case 'TMV':
      return 'Thuyết minh tiếng Việt';
    default:
      return code;
  }}

