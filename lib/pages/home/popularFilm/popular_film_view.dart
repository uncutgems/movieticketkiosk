import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/home/popularFilm/popular_film_bloc.dart';

class PopularFilmWidget extends StatefulWidget {
  @override
  _PopularFilmWidgetState createState() => _PopularFilmWidgetState();
}

class _PopularFilmWidgetState extends State<PopularFilmWidget> {
  final PopularFilmBloc bloc = PopularFilmBloc();

  @override
  void initState() {
    bloc.add(GetDataPopularFilmEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularFilmBloc, PopularFilmState>(
      cubit: bloc,
      builder: (BuildContext context, PopularFilmState state) {
        if (state is InitialPopularFilmState) {
          return Container();
        }
        if (state is SuccessGetDataPopularFilmState) {
          return _body(context, state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataPopularFilmState state) {
//    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<Film> filmList = state.filmList;
    return Column(
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: filmList.length,
          options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              aspectRatio: 16 / 9,
              autoPlay: true,
              height: screenHeight / 667 * 330,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                bloc.add(ChangedPagePopularFilmEvent(index, filmList));
              }),
          itemBuilder: (BuildContext context, int index) {
            final Film film = filmList[index];
            return GestureDetector(
              onTap: () {
                print('navigate to film detail');
              },
              child: Container(
                decoration: filmBoxDecoration.copyWith(
                  color: AppColor.primaryDarkColor,
                  image: DecorationImage(
                    image: NetworkImage(film.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
        _filmInfo(context, filmList, state.index)
      ],
    );
  }

  Widget _filmInfo(BuildContext context, List<Film> filmList, int index) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final Film film = filmList[index];
    final List<String> version = film.versionCode.split('/');
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: screenWidth / 11 * 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  film.filmName,
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
                          style:
                              textTheme.bodyText2.copyWith(color: AppColor.red),
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
                  film.duration.toString() +
                      'p'
                          '-' +
                      film.premieredDay
                          .substring(0, film.premieredDay.indexOf('T')),
                  style:
                      textTheme.bodyText2.copyWith(color: AppColor.borderTrip),
                ),
              ],
            ),
          ),
          RaisedButton(
            child: const Text('Đặt vé'),
            color: AppColor.buttonColor,
            onPressed: () {
              print('navigate to đặt vé');
            },
          )
        ],
      ),
    );
  }
}
