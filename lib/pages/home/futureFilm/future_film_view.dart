import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/style.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<FutureFilmBloc, FutureFilmState>(
      cubit: bloc,
      builder: (BuildContext context, FutureFilmState state) {
        if (state is InitialFutureFilmState) {
          return Container();
        } else if (state is SuccessGetDataFutureFilmState) {
          return _body(context, state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataFutureFilmState state) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<Film> futureFilmList = state.listFilm;
    return Container(
      height: screenHeight/ 667 * 310,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final Film futureFilm = futureFilmList[index];
            final List<String> version = futureFilm.versionCode.split('/');
            return Column(
              children: <Widget>[
                Container(
                  decoration: filmBoxDecoration.copyWith(
                    color: AppColor.primaryDarkColor,
                    image: DecorationImage(
                      image: NetworkImage(futureFilm.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: screenWidth / 11 * 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        futureFilm.filmName,
                        style: textTheme.bodyText2.copyWith(
                            color: AppColor.white, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: screenHeight / 667 * 20,
                        width: screenWidth / 10 * 1,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            width: 4,
                          ),
                          itemCount: version.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final String versionCode = version[index];
                            return Container(
                              child: Text(
                                versionCode,
                                style: textTheme.bodyText2
                                    .copyWith(color: AppColor.red),
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
                      ),
                      Text(
                        futureFilm.duration.toString() +
                            'p'
                                '-' +
                            futureFilm.premieredDay.substring(
                                0, futureFilm.premieredDay.indexOf('T')),
                        style: textTheme.bodyText2
                            .copyWith(color: AppColor.borderTrip),
                      ),
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
    );
  }
}
