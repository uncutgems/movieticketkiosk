import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/film_schedule/film_schedule_bloc.dart';
import 'package:ncckios/widgets/calendar/date_helper.dart';
import 'package:ncckios/widgets/calendar/horizontal_calendar.dart';
import 'package:ncckios/widgets/container/language_code_widget.dart';
import 'package:ncckios/widgets/container/version_code_container.dart';
import 'package:ncckios/widgets/faling_widget/failing_widget.dart';
import 'package:ncckios/widgets/shortcut/shortcut.dart';

class FilmSchedulePage extends StatefulWidget {
  const FilmSchedulePage({Key key, @required this.film}) : super(key: key);

  final Film film;

  @override
  _FilmSchedulePageState createState() => _FilmSchedulePageState();
}

class _FilmSchedulePageState extends State<FilmSchedulePage> {
  DateTime currentDate = DateTime.now();
  FilmScheduleBloc bloc = FilmScheduleBloc();

  final Comparator<Session> comparator = (Session a, Session b) => DateTime.parse(a.projectTime)
      .millisecondsSinceEpoch
      .compareTo(DateTime.parse(b.projectTime).millisecondsSinceEpoch);
  bool pressCalendar = false;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    bloc.add(FilmScheduleEventGetTime(convertDateToInput(DateTime.now()), widget.film.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmScheduleBloc, FilmScheduleState>(
      cubit: bloc,
      buildWhen: (FilmScheduleState prev, FilmScheduleState state) {
        if (state is FilmScheduleStateToSelectSeatPage) {
          Navigator.pushNamed(context, RoutesName.selectSeatPage, arguments: <String, dynamic>{
            Constant.session: state.session,
            Constant.film: widget.film,
          });
          return false;
        }
        return true;
      },
      builder: (BuildContext context, FilmScheduleState state) {
        if (state is FilmScheduleInitial) {
          return mainScreen(context, Container());
        } else if (state is FilmScheduleStateFail) {
          return mainScreen(
              context,
              FailingWidget(
                  errorMessage: state.errorMess,
                  onPressed: () {
                    bloc.add(FilmScheduleEventGetTime(convertDateToInput(currentDate), widget.film.id));
                  }));
        } else if (state is FilmScheduleStateGetTime) {
          pressCalendar = true;
          return mainScreen(context, _columnSessionShowing(context, state.sessionList));
        } else if (state is FilmScheduleStateLoading) {
          pressCalendar = false;
          return mainScreen(context, _loading(context));
        } else if (state is FilmScheduleStateEmpty) {
          pressCalendar = true;
          return mainScreen(
            context,
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Text(
                  'Xin lỗi bạn ngày này chưa có lịch chiếu',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: AppColor.white),
                ),
              ),
            ),
          );
        }
        return const Material();
      },
    );
  }

  Widget mainScreen(BuildContext context, Widget widget) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: AppSize.getHeight(context, 20),
            ),
            onPressed: () => Navigator.pop(context, RoutesName.filmSchedulePage)),
        elevation: 0.0,
        title: Text(
          'Chọn suất chiếu',
          style: textTheme.bodyText1.copyWith(
            color: AppColor.dark20,
            fontWeight: FontWeight.w500,
            fontSize: AppSize.getFontSize(context, 20),
          ),
        ),
        toolbarHeight: AppSize.getHeight(context, 48),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: AppSize.getWidth(context, 8),
            ),
            child: HorizontalCalendar(
              pressCalender: pressCalendar,
              initialSelectedDates: <DateTime>[DateTime.now()],
              spacingBetweenDates: AppSize.getWidth(context, 8),
              onDateSelected: (DateTime date) {
                currentDate = date;
                bloc.add(FilmScheduleEventGetTime(convertDateToInput(date), this.widget.film.id));
              },
              height: AppSize.getHeight(context, 40),
              padding: const EdgeInsets.all(0),
              labelOrder: const <LabelType>[LabelType.weekday, LabelType.date],
              weekDayFormat: 'EEEE',
              dateFormat: 'dd/MM',
              dateTextStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: AppColor.white, fontSize: AppSize.getFontSize(context, 14)),
              weekDayTextStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: AppColor.white, fontSize: AppSize.getFontSize(context, 14)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 6)),
              selectedDateTextStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: AppColor.red, fontSize: AppSize.getFontSize(context, 14)),
              selectedWeekDayTextStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: AppColor.red, fontSize: AppSize.getFontSize(context, 14)),
            ),
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * (11 / 667),
          ),
          gradientLine(context),
          widget
        ],
      ),
    );
  }

  Widget _columnSessionShowing(BuildContext context, List<Session> session) {
    return Column(
      children: _sessionShowing(context, session),
    );
  }

  List<Widget> _sessionShowing(BuildContext context, List<Session> session) {
    final List<SessionType> sessionTypeList = categorizeSession(session);
    final List<List<Session>> sessionLists = <List<Session>>[];
    sessionLists.addAll(sessionTypeList.map((SessionType sessionType) => sessionType.sessionList).toList());
    return sessionLists.map((List<Session> sessions) => timeButton(context, sessions)).toList();
//    for (final SessionType sessionType in sessionTypeList) {
//      sessionLists.add(sessionType.sessionList);
//    }

//    final List<Widget> result = <Widget>[];
//    for (final List<Session> element in sessionLists) {
//      result.add(timeButton(context, element));
//    }
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
      final bool check =
          DateTime
              .parse(element.projectTime)
              .millisecondsSinceEpoch < DateTime
              .now()
              .millisecondsSinceEpoch;
      listWidget.add(Padding(
        padding: EdgeInsets.only(right: AppSize.getWidth(context, 8), top: AppSize.getHeight(context, 4)),
        child: RaisedButton(
          color: AppColor.white,
          disabledColor: AppColor.disableColor,
          onPressed: check
              ? null
              : () {
            bloc.add(FilmScheduleEventClickTimeBox(element));
          },
          padding: EdgeInsets.all(AppSize.getWidth(context, 10).toDouble()),
          elevation: 0,
          child: Text(
            element.projectTime.substring(11, element.projectTime.length - 3),
            style: Theme
                .of(context)
                .textTheme
                .button
                .copyWith(fontWeight: FontWeight.w500, fontSize: AppSize.getFontSize(context, 14)),
          ),
        ),
      ));
    }
    final Widget result = Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * (16 / 360),
          top: AppSize.getHeight(context, 27),
          bottom: AppSize.getHeight(context, 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // versionCodeWidget(context, versionCode),
            VersionCodeContainer(context: context, versionCode: versionCode),
            Container(
              width: AppSize.getWidth(context, 4),
            ),
            LanguageCodeContainer(
              languageCode: languageCode,
            ),
          ],
        ),
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

  Widget _loading(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
          ),
        ),
      ],
    );
  }

  List<SessionType> categorizeSession(List<Session> sessionList) {
    final List<SessionType> result = <SessionType>[];
    bool check = false;
    int index = 0;
    for (final Session element in sessionList) {
      if (result.isEmpty) {
        print('not fuck');
        final SessionType a =
        SessionType(versionCode: element.versionCode, languageCode: element.languageCode, sessionList: <Session>[]);
        a.sessionList.add(element);
        result.add(a);
      } else {
        for (int i = 0; i < result.length; i++) {
          if (result[i].versionCode != element.versionCode || result[i].languageCode != element.languageCode) {
            check = true;
          } else {
            index = i;
            check = false;
          }
        }
        if (check) {
          final SessionType a = SessionType(
              versionCode: element.versionCode, languageCode: element.languageCode, sessionList: <Session>[]);
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
