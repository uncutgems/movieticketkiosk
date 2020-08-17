import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/home/futureFilm/future_film_bloc.dart';

class FutureFilmWidget extends StatefulWidget {
  @override
  _FutureFilmWidgetState createState() => _FutureFilmWidgetState();
}

class _FutureFilmWidgetState extends State<FutureFilmWidget> {
  final FutureFilmBloc bloc = FutureFilmBloc();

  @override
  void initState() {
    bloc.add(GetDataFutureFilmEvent());
    super.initState();
  }
@override
  void dispose() {
    bloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FutureFilmBloc, FutureFilmState>(
      cubit: bloc,
      builder: (BuildContext context, FutureFilmState state) {
        if (state is SuccessGetDataFutureFilmState) {
          return _body(context, state);
        } else if (state is FailGetDataFutureFilmState) {
          return _failToLoad(context, state);
        }
        else {
          return Container();
        }
      },
        buildWhen: (FutureFilmState prev, FutureFilmState current) {
          if (current is NavigateDetailFutureFilmState) {
            _navigateToDetail(context, current);
            return false;
          } else {
            return true;
          }
        });
  }

  Widget _body(BuildContext context, SuccessGetDataFutureFilmState state) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<Film> futureFilmList = state.listFilm;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 360 * 16),
      child: Container(
        height: screenHeight / 667 * 350,
        child:  ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final Film futureFilm = futureFilmList[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      bloc.add(ClickToDetailFutureFilmEvent(futureFilm.id));
                    },
                    child: Container(
                        width: screenWidth / 9 * 4,
                        height: screenHeight / 667 * 240,
                        decoration: filmBoxDecoration.copyWith(
                            color: AppColor.primaryDarkColor,
                            image: futureFilm.imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(futureFilm.imageUrl),
                                    fit: BoxFit.cover,
                                  )
                                : null),
                        child: futureFilm.id == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : null),
                  ),
                  Container(
                    height: screenHeight / 667 * 8,
                  ),
                  Container(
                    width: screenWidth / 11 * 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        if (futureFilm.id != null) SizedBox(
                          height: screenHeight / 667 * 32,
                          child: Text(
                            futureFilm.filmName
                                .substring(0, futureFilm.filmName.indexOf('-')),
                            style: textTheme.bodyText2.copyWith(
                                color: AppColor.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ) else Container(),
                        Container(
                          height: screenHeight / 667 * 8,
                        ),
                        if (futureFilm.id != null) Container(
                          height: screenHeight / 667 * 20,
                          width: screenWidth / 10 * 1,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                Container(width: 4),
                            itemCount: futureFilm.versionCode.split('/').length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final List<String> version = futureFilm.versionCode.split('/');
                              final String versionCode = version[index];
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: screenHeight/667*3, horizontal: screenWidth/360*4),
                                child: Center(
                                  child: Text(
                                    versionCode,
                                    style: textTheme.bodyText2
                                        .copyWith(color: AppColor.red),
                                  ),
                                ),
                                height: screenHeight / 667 * 16,
                                decoration: BoxDecoration(
                                  color: AppColor.backGround,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColor.red,
                                      style: BorderStyle.solid),
                                ),
                              );
                            },
                          ),
                        ) else Container(),
                        Container(
                          height: screenHeight / 667 * 8,
                        ),
                        if (futureFilm.id != null) Text(
                          '${futureFilm.duration.toString()}p  - ${convertTime('dd/MM/yyyy', DateTime
                              .parse(futureFilm.premieredDay)
                              .millisecondsSinceEpoch, false)}',
                          style: textTheme.bodyText2
                              .copyWith(color: AppColor.borderTrip),
                        ) else Container(),

                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: screenWidth / 90 * 4,
                ),
            itemCount: futureFilmList.length),
      ),
    );
  }
  void _navigateToDetail(
      BuildContext context, NavigateDetailFutureFilmState state) {
    Navigator.pushNamed(context, RoutesName.detailPage, arguments: state.id);
  }

  Widget _failToLoad (BuildContext context, FailGetDataFutureFilmState state) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight/ 667*310,
      width: screenWidth,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(state.error, style: textTheme.headline6,),
            Container(
              height: 8,
            ),
            IconButton(
              icon: const Icon(Icons.refresh, size: 36,),
              onPressed: () {
                bloc.add(GetDataFutureFilmEvent());
              },
            )
          ],
        ),
      ),
    );
  }


}
