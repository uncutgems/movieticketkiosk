import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class FilmSchedulePage extends StatefulWidget {
  @override
  _FilmSchedulePageState createState() => _FilmSchedulePageState();
}

class _FilmSchedulePageState extends State<FilmSchedulePage> {
  final CalendarController _calendarController = CalendarController();
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print('Hello World');

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Chọn suất chiếu',
          style: Theme.of(context).textTheme.headline6.copyWith(
              color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calendarBoxDay(context, DateTime.now()),
              calendarBoxDay(
                  context, DateTime.now().add(const Duration(days: 1))),
              calendarBoxDay(
                  context, DateTime.now().add(const Duration(days: 2))),
              calendarBoxDay(
                  context, DateTime.now().add(const Duration(days: 3))),
              calendarBoxDay(
                  context, DateTime.now().add(const Duration(days: 4))),
              calendarBoxDay(
                  context, DateTime.now().add(const Duration(days: 5))),
            ],
          )
        ],
      ),
    );
  }

  Widget calendarSlide(BuildContext context) {
    return TableCalendar(
      locale: 'vi',
      calendarController: _calendarController,
//        events: _events,
//        holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,

      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const <CalendarFormat, String>{
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
    );
  }

  Widget calendarBoxDay(BuildContext context, DateTime date) {
    String formattedDay = DateFormat('EEEE', 'vi').format(date);
    final String formattedDate = DateFormat('dd/mm').format(date);
    if (date.day == DateTime.now().day) {
      formattedDay = 'Hôm nay';
    }
    Color color = AppColor.white;
    if (date.day > 2 + DateTime.now().day) {
      color = AppColor.disableColor;
    }

    return GestureDetector(
      onTap: () {
        color = AppColor.red;
        currentDate = date;
        print('Current $currentDate');
        print('hello');
      },
      child: Container(
        child: Column(children: <Widget>[
          Text(
            formattedDay,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          Container(
            height: 4,
          ),
          Text(
            formattedDate,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: 14,
                  color: color,
                ),
          )
        ]),
      ),
    );
  }
}
