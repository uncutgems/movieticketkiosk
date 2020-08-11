import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/pages/film_schedule/film_schedule_bloc.dart';
import 'package:ncckios/widgets/calendar/date_helper.dart';
import 'package:ncckios/widgets/calendar/horizontal_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class FilmSchedulePage extends StatefulWidget {
  @override
  _FilmSchedulePageState createState() => _FilmSchedulePageState();
}

class _FilmSchedulePageState extends State<FilmSchedulePage> {
  DateTime currentDate = DateTime.now();
  FilmScheduleBloc bloc = FilmScheduleBloc();


  @override
  void initState() {
    bloc.add(FilmScheduleEventGetTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmScheduleBloc, FilmScheduleState>(
    cubit: bloc,
      builder: (BuildContext context, FilmScheduleState state) {
        if (state is FilmScheduleInitial) {
          return mainScreen(context);
        } else if (state is FilmScheduleStateGetTime) {
          return mainScreen(context);
        }
        return const Material();
      },
    );
  }



  Widget mainScreen(BuildContext context){
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
          HorizontalCalendar(
            height: 32,
            onDateSelected: (DateTime date){
              currentDate =date;
              print('llll $currentDate');
            },
            padding: const EdgeInsets.all(0),
            labelOrder: const <LabelType>[LabelType.weekday,LabelType.date],
            weekDayFormat: 'EEEE',
            dateFormat: 'dd/MM',
            dateTextStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColor.white),
            weekDayTextStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColor.white),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 6)),
            selectedDecoration: const BoxDecoration(
                color: AppColor.red
            ),
          )

        ],
      ),
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
