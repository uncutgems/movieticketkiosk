import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(
        title: const Text('Phim nổi bật'),
      ),
      body: ListView(
        children: <Widget>[
          PopularFilmWidget(),
          Image.asset('assets/divider.png'),
          const Text('Phim sắp chiếu')

        ],
      ),
    );
  }
}
