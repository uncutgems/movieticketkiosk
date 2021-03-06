import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/home/popularFilm/popular_film_bloc.dart';
import 'package:ncckios/widgets/button/button_widget.dart';
import 'package:ncckios/widgets/container/version_code_container.dart';
import 'package:ncckios/widgets/loading/loading_widget.dart';

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
        if (state is SuccessGetDataPopularFilmState) {
          return _body(context, state);
        } else if (state is FailGetDataPopularFilmState) {
          return _failToLoad(context, state);
        } else {
          return Container();
        }
      },
      buildWhen: (PopularFilmState prev, PopularFilmState current) {
        if (current is NavigateDetailPopularFilmState) {
          _navigateToDetail(context, current);
          return false;
        } else {
          return true;
        }
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataPopularFilmState state) {
    final List<Film> filmList = state.filmList;
    return Column(
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: filmList.length,
          options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              viewportFraction: 0.6,
              aspectRatio: 16 / 9,
              autoPlay: true,
              height: AppSize.getWidth(context, 330),
              autoPlayAnimationDuration: const Duration(seconds: 2),
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                bloc.add(ChangedPagePopularFilmEvent(index, filmList));
              }),
          itemBuilder: (BuildContext context, int index) {
            final Film film = filmList[index];
            return GestureDetector(
              onTap: () {
                film.id == null
                    ? print('not yet')
                    : bloc.add(ClickToDetailPopularFilmEvent(film.id));
              },
              child: Container(
                decoration: filmBoxDecoration.copyWith(
                  color: AppColor.primaryDarkColor,
                  image: film.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(film.imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: film.id == null
                    ? Center(child: LoadingWidget())
                    : null,
              ),
            );
          },
        ),
        Container(
          height: AppSize.getWidth(context, 8),
        ),
        if (filmList[0].id != null)
          _filmInfo(context, filmList, state.index)
        else
          Container(),
      ],
    );
  }

  Widget _filmInfo(BuildContext context, List<Film> filmList, int index) {
    final Film film = filmList[index];

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.getWidth(context, 16),
          vertical: AppSize.getWidth(context, 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: AppSize.getWidth(context, 163),
            height: AppSize.getWidth(context, 106),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  child: Text(
                    film.filmName,
                    style: textTheme.bodyText2.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.getFontSize(context, 16)),
                    maxLines: 2,
                  ),
                ),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                VersionCodeContainer(
                  context: context,
                  versionCode: film.versionCode,
                ),
                Container(
                  height: AppSize.getWidth(context, 8),
                ),
                Text(
                  '${film.duration.toString()}p  - ${convertTime('dd/MM/yyyy', DateTime.parse(film.premieredDay).millisecondsSinceEpoch, false)}',
                  style: textTheme.bodyText2.copyWith(
                      color: AppColor.borderTrip,
                      fontSize: AppSize.getFontSize(context, 14)),
                ),
              ],
            ),
          ),
          AVButtonFill(
              title: '?????T V??',
              onPressed: () {
                film.id == null
                    ? print('not yet')
                    : bloc.add(ClickToDetailPopularFilmEvent(film.id));
              })
        ],
      ),
    );
  }

  void _navigateToDetail(
      BuildContext context, NavigateDetailPopularFilmState state) {
    Navigator.pushNamed(context, RoutesName.detailPage,
        arguments: <String, dynamic>{
          Constant.filmId: state.id,
          Constant.isPlayNow: true,
        });
  }

  Widget _failToLoad(BuildContext context, FailGetDataPopularFilmState state) {
    return Container(
      height: AppSize.getWidth(context, 330),
      width: AppSize.getWidth(context, 360),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              state.error,
              style: textTheme.headline6,
            ),
            Container(
              height: 8,
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: AppSize.getWidth(context, 36),
              ),
              onPressed: () {
                bloc.add(GetDataPopularFilmEvent());
              },
            )
          ],
        ),
      ),
    );
  }
}
