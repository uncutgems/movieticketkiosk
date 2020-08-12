import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/film_schedule/film_schedule_bloc.dart';
import 'package:ncckios/widgets/calendar/date_helper.dart';
import 'package:ncckios/widgets/calendar/horizontal_calendar.dart';
import 'package:ncckios/widgets/shortcut/shortcut.dart';

class FilmSchedulePage extends StatefulWidget {
  @override
  _FilmSchedulePageState createState() => _FilmSchedulePageState();
}

class _FilmSchedulePageState extends State<FilmSchedulePage> {
  DateTime currentDate = DateTime.now();
  FilmScheduleBloc bloc = FilmScheduleBloc();
  final Comparator<Session> comparator = (Session a, Session b) =>
      DateTime.parse(a.projectTime)
          .millisecondsSinceEpoch
          .compareTo(DateTime.parse(b.projectTime).millisecondsSinceEpoch);

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    bloc.add(
        FilmScheduleEventGetTime(convertDateToInput(DateTime.now()), 9460));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmScheduleBloc, FilmScheduleState>(
      cubit: bloc,
      buildWhen: (FilmScheduleState prev, FilmScheduleState state) {
        if (state is FilmScheduleStateFail) {
          fail(state.errorMess, context);
          return false;
        }
        else if(state is FilmScheduleStateToSelectSeatPage){
          Navigator.pushNamed(context, RoutesName.selectSeatPage);
          return false;
        }
        return true;
      },
      builder: (BuildContext context, FilmScheduleState state) {
        if (state is FilmScheduleInitial) {
          return mainScreen(context, Container());
        } else if (state is FilmScheduleStateGetTime) {
          return mainScreen(
              context, columnSessionShowing(context, state.sessionList));
        } else if (state is FilmScheduleStateLoading) {
          return mainScreen(context, _loading(context));
        } else if (state is FilmScheduleStateEmpty) {
          return mainScreen(
              context,
              Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child:  Center(
                    child: Text('Xin lỗi bạn ngày này chưa có lịch chiếu',style: Theme.of(context).textTheme.headline6,),

                  )));
        }
        return const Material();
      },
    );
  }

  Widget mainScreen(BuildContext context, Widget widget) {
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
              bloc.add(
                  FilmScheduleEventGetTime(convertDateToInput(date), 9460));
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
          Container(
            height: MediaQuery.of(context).size.height * (11 / 667),
          ),
          gradientLine(context),
          widget
        ],
      ),
    );
  }

  Widget columnSessionShowing(BuildContext context, List<Session> session) {
    return Column(
      children: sessionShowing(context, session),
    );
  }

  List<Widget> sessionShowing(BuildContext context, List<Session> session) {
//    final List<Session> session = state.sessionList;
    final List<SessionType> sessionTypeList = categorizeSession(session);
    final List<List<Session>> sessionLists = <List<Session>>[];
    for (final SessionType sessionType in sessionTypeList) {
      sessionLists.add(sessionType.sessionList);
    }
    final List<Widget> result = <Widget>[];
    for (final List<Session> element in sessionLists) {
      result.add(timeButton(context, element));
    }
    return result;
  }

  Widget timeButton(BuildContext context, List<Session> sessionList) {
    sessionList.sort(comparator);
    if (sessionList.isEmpty) {
      return Container();
    }
    final String versionCode = sessionList.first.versionCode;
    final String languageCode = sessionList.first.languageCode;
    final List<Widget> listWidget = <Widget>[];
    for (final Session element in sessionList) {
      listWidget.add(Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 8),
        child: RaisedButton(
          color: AppColor.white,
          onPressed: () {
            bloc.add(FilmScheduleEventClickTimeBox());
          },
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
    final Widget result = Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * (16 / 360),
                right: MediaQuery.of(context).size.width * (4 / 360),
                top: MediaQuery.of(context).size.height * (29 / 667)),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(border: Border.all(color: AppColor.red)),
            child: Text(
              versionCode,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 14, color: AppColor.red),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * (29 / 667)),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(border: Border.all(color: AppColor.red)),
            child: Text(
              languageCode,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 14, color: AppColor.red),
            ),
          ),
        ],
      ),
      GridView.count(
        crossAxisCount: 4,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * (16 / 360),
            right: MediaQuery.of(context).size.width * (36 / 360)),
        childAspectRatio: 2,
        children: listWidget,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    ]);

    return result;
  }

  List<Session> sessionType(
      List<Session> sessionList, String versionCode, String languageCode) {
    final List<Session> listSession = <Session>[];
    for (final Session element in sessionList) {
      if (element.versionCode == versionCode &&
          element.languageCode == languageCode) {
        listSession.add(element);
      }
    }
    final Comparator<Session> comparator = (Session a, Session b) =>
        DateTime.parse(a.projectTime)
            .millisecondsSinceEpoch
            .compareTo(DateTime.parse(b.projectTime).millisecondsSinceEpoch);
    listSession.sort(comparator);
    return listSession;
  }

  Widget _loading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
      ),
    );
  }

  List<SessionType> categorizeSession(List<Session> sessionList) {
    final List<SessionType> result = <SessionType>[];
    bool check = false;
    int index = 0;
    for (final Session element in sessionList) {
      if (result.isEmpty) {
        print('not fuck');
        final SessionType a = SessionType(
            versionCode: element.versionCode,
            languageCode: element.languageCode,
            sessionList: <Session>[]);
        a.sessionList.add(element);
        result.add(a);
      } else {
        for (int i = 0; i < result.length; i++) {
          if (result[i].versionCode != element.versionCode ||
              result[i].languageCode != element.languageCode) {
            check = true;
            index = i;
          }
        }
        if (check) {
          final SessionType a = SessionType(
              versionCode: element.versionCode,
              languageCode: element.languageCode,
              sessionList: <Session>[]);
          a.sessionList.add(element);
          print('fuck');
          result.add(a);
          check = false;
        } else {
          result[index].sessionList.add(element);
        }
      }
    }
    print('This is ${result.length}');
    return result;
  }

}
