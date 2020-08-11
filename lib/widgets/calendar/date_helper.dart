List<DateTime> getDateList(
  DateTime firstDate,
  DateTime lastDate,
) {
  final List<DateTime> list = <DateTime>[toDateMonthYear(firstDate)];
  while (list.last.compareTo(toDateMonthYear(lastDate)) == -1) {
    list.add(toDateMonthYear(list.last.add(const Duration(days: 1))));
  }
  return list;
}

DateTime toDateMonthYear(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

enum LabelType {
  date,
  month,
  weekday,
}
