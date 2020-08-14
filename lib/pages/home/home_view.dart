import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/pages/home/futureFilm/future_film_view.dart';
import 'package:ncckios/pages/home/home_bloc.dart';
import 'package:ncckios/pages/home/popularFilm/popular_film_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: bloc,
      builder: (BuildContext context, HomeState state) {
        if (state is HomeInitialHomeState) {
          return _body(context);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Phim nổi bật',
                  style: textTheme.bodyText2.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Image.asset('assets/iconfilm.png'),
              ],
            ),
          ),
          PopularFilmWidget(),
          Image.asset('assets/divider.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Phim sắp chiếu',
              style: textTheme.bodyText2.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          FutureFilmWidget(),
        ],
      ),
    );
  }
}
