import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/film_schedule/film_schedule_bloc.dart';
import 'package:ncckios/widgets/calendar/date_helper.dart';
import 'package:ncckios/widgets/calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';

class FilmSchedulePage extends StatefulWidget {
  @override
  _FilmSchedulePageState createState() => _FilmSchedulePageState();
}

class _FilmSchedulePageState extends State<FilmSchedulePage> {
  DateTime currentDate = DateTime.now();
  FilmScheduleBloc bloc = FilmScheduleBloc();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    bloc.add(FilmScheduleEventGetTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmScheduleBloc, FilmScheduleState>(
      cubit: bloc,
      buildWhen: (FilmScheduleState prev, FilmScheduleState state) {
        if (state is FilmScheduleStateLoading) {
          _showLoading();
          return false;
        } else if (state is FilmScheduleStateDismissLoading) {
          Navigator.pop(context);
          return false;
        }
        return true;
      },
      builder: (BuildContext context, FilmScheduleState state) {
        if (state is FilmScheduleInitial) {
          return initialPage(context);
        } else if (state is FilmScheduleStateGetTime) {
          return mainScreen(context, state);
        }
        return const Material();
      },
    );
  }

  Widget mainScreen(BuildContext context, FilmScheduleStateGetTime state) {
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
            spacingBetweenDates: 8,
            height: 32,
            onDateSelected: (DateTime date) {
              currentDate = date;
              print('llll $currentDate');
            },
            padding: const EdgeInsets.all(0),
            labelOrder: const <LabelType>[LabelType.weekday, LabelType.date],
            weekDayFormat: 'EEEE',
            dateFormat: 'dd/MM',
            dateTextStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AppColor.white),
            weekDayTextStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AppColor.white),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 6)),
            selectedDecoration: const BoxDecoration(color: AppColor.red),
          ),
          sessionShowing(context, state)
        ],
      ),
    );
  }

  Widget sessionShowing(BuildContext context, FilmScheduleStateGetTime state) {
    final List<Session> session = state.sessionList;

    final Comparator<Session> comparator = (Session a,Session b)=>DateTime.parse(a.projectTime).millisecondsSinceEpoch.compareTo(DateTime.parse(b.projectTime).millisecondsSinceEpoch);
    session.sort(comparator);
    final List<Widget> listWidget = <Widget>[];

    for (final Session element in session) {
      listWidget.add(Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 16),
        child: RaisedButton(
          color: AppColor.white,
          onPressed: () {},
          padding: const EdgeInsets.all(10),
          elevation: 0,
          child: Text(
            element.projectTime.substring(11, element.projectTime.length - 3),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ));
    }



    final Widget gridView = GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 2,
      children: listWidget,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );

    return gridView;
  }


  void _showLoading() {
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
//            mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                CircularProgressIndicator(),
                Text('Loading'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget initialPage(BuildContext context) {
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
            onDateSelected: (DateTime date) {
              currentDate = date;
              print('llll $currentDate');
            },
            padding: const EdgeInsets.all(0),
            labelOrder: const <LabelType>[LabelType.weekday, LabelType.date],
            weekDayFormat: 'EEEE',
            dateFormat: 'dd/MM',
            dateTextStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AppColor.white),
            weekDayTextStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AppColor.white),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 6)),
            selectedDecoration: const BoxDecoration(color: AppColor.red),
          ),
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
