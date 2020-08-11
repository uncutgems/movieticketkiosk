import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../base/style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _body(BuildContext context) {
    final List<String> film = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phim nổi bật'),
      ),
      body: ListView(
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: film.length,
            options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height / 3 * 1),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print('tap film');
                },
                child: Container(
                  decoration: filmBoxDecoration,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget filmInfo(BuildContext context, String filmName, List<String> version,
      DateTime premiereDay, int duration) {
    return Column(
      children: <Widget>[
        Text(filmName),
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
              child: Text(versionCode),
            );
          },
        )
      ],
    );
  }
}
