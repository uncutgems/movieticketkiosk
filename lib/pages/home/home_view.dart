import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/home/home_bloc.dart';

import '../../base/color.dart';
import '../../base/style.dart';
import '../../base/tool.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc bloc = HomeBloc();
  @override
  void initState() {
    bloc.add(GetDataHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: bloc,
      builder: (BuildContext context, HomeState state) {
        if (state is HomeInitialHomeState) {
          return Container();
        } else if (state is SuccessGetDataHomeState) {
          return _body(context, state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataHomeState state) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<Film> filmList = state.listFilm;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phim nổi bật'),
      ),
      body: ListView(
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: filmList.length,
            options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                height: screenHeight / 3 * 1),
            itemBuilder: (BuildContext context, int index) {
              final Film film = filmList[index];
              return GestureDetector(
                onTap: () {
                  print('navigate to film detail');
                },
                child: _filmPoster(context, film, screenHeight),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _filmPoster(BuildContext context, Film film, double screenHeight) {
  return Column(
    children: <Widget>[
      Container(
        decoration: filmBoxDecoration.copyWith(
          image: DecorationImage(
            image: NetworkImage(film.imageUrl),
            fit: BoxFit.fill
          ),
        ),
      ),
      _filmInfo(context, film, screenHeight)
    ],
  );
}

Widget _filmInfo(BuildContext context, Film film, double screenHeight) {
  final List<String> version = film.versionCode.split('/');
  return Column(
    children: <Widget>[
      Text(film.filmName),
      ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 4,
        ),
        itemCount: version.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final String versionCode = version[index];
          return Container(
            child: Text(
              versionCode,
              style: textTheme.bodyText2.copyWith(color: AppColor.red),
            ),
            height: screenHeight / 1 * 0.025,
            decoration: BoxDecoration(
              color: AppColor.backGround,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  width: 1, color: AppColor.red, style: BorderStyle.solid),
            ),
          );
        },
      ),
      Text(
        film.duration.toString() +
            '-' +
            film.premieredDay.substring(0, film.premieredDay.indexOf('T')),
        style: textTheme.bodyText2.copyWith(color: AppColor.borderTrip),
      ),
    ],
  );
}
