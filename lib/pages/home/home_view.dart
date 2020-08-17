import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
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
            padding: EdgeInsets.symmetric(horizontal: AppSize.getWidth(context, 16), vertical: AppSize.getHeight(context, 16) ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Phim nổi bật',
                  style: textTheme.bodyText2.copyWith(fontSize: AppSize.getFontSize(context, 18), fontWeight: FontWeight.w500),
                ),

                GestureDetector(child: Image.asset('assets/search.png',scale: 1.25,),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.findTicketPage);
                },),
              ],
            ),
          ),
          PopularFilmWidget(),
          Image.asset('assets/divider.png'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.getWidth(context, 16), vertical: AppSize.getHeight(context, 16) ),
            child: Text(
              'Phim sắp chiếu',
              style: textTheme.bodyText2.copyWith(
                fontSize: AppSize.getFontSize(context, 18),
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
