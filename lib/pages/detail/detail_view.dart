import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/detail/detail_bloc.dart';
import 'package:ncckios/widgets/button/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key, @required this.id}) : super(key: key);
  final int id;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DetailBloc bloc = DetailBloc();

  @override
  void initState() {
    bloc.add(GetDataDetailEvent(widget.id));
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      cubit: bloc,
      builder: (BuildContext context, DetailState state) {
        if (state is SuccessGetDataDetailState) {
          return _body(context, state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataDetailState state) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final Film film = state.film;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin phim',
          style: textTheme.bodyText1
              .copyWith(color: AppColor.dark20, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: screenHeight / 667 * 327,
            width: screenWidth,
            color: AppColor.white,
            child: Stack(
              children: <Widget>[
                if (film.id != null) Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(film.bannerUrl),
                  )),
                  width: screenWidth,
                  height: screenHeight / 667 * 240,
                  child: Center(
                    child: FloatingActionButton(
                      child: const Icon(Icons.play_arrow),
                      elevation: 0.6,
                      onPressed: () {
                        _launchURL(film.videoUrl);
                      },
                    ),
                  ),
                ) else Container(child: const Center(child: CircularProgressIndicator(),),),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                            bottom: Radius.circular(0))),
                    height: screenHeight / 667 * 125,
                    width: screenWidth,
                    child: film.id != null
                        ? _filmInfo(context, film)
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                )
              ],
            ),
          ),
          Image.asset('assets/divider.png'),
          if (film.id != null) Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 0),
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 340 * 16,
                      vertical: screenHeight / 667 * 8),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FractionColumnWidth(0.4)
                    },
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              'Kiểm duỵệt',
                              textAlign: TextAlign.end,
                              style: textTheme.subtitle2
                                  .copyWith(color: AppColor.borderTrip),
                            ),
                          ),
                          Text(
                            film.description,
                            style: textTheme.bodyText2
                                .copyWith(color: AppColor.border),
                          ),
                        ],
                      ),
                      TableRow(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Khởi chiếu',
                            textAlign: TextAlign.end,
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.borderTrip),
                          ),
                        ),
                        Text(
                          film.premieredDay.substring(0, film.premieredDay.indexOf('T')),
                          style: textTheme.bodyText2
                              .copyWith(color: AppColor.border),
                        ),
                      ]),
                      TableRow(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Thể loại',
                            textAlign: TextAlign.end,
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.borderTrip),
                          ),
                        ),
                        Text(
                          film.category,
                          style: textTheme.bodyText2
                              .copyWith(color: AppColor.border),
                        ),
                      ]),
                      TableRow(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Đạo diễn',
                            textAlign: TextAlign.end,
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.borderTrip),
                          ),
                        ),
                        Text(
                          film.director,
                          style: textTheme.bodyText2
                              .copyWith(color: AppColor.border),
                        ),
                      ]),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Diễn viên',
                              textAlign: TextAlign.end,
                              style: textTheme.subtitle2
                                  .copyWith(color: AppColor.borderTrip),
                            ),
                          ),
                          Text(
                            film.actors,
                            style: textTheme.bodyText2
                                .copyWith(color: AppColor.border),
                          ),
                        ],
                      ),
                      TableRow(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Thời lượng',
                            textAlign: TextAlign.end,
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.borderTrip),
                          ),
                        ),
                        Text(
                          film.duration.toString() + ' phút',
                          style: textTheme.bodyText2
                              .copyWith(color: AppColor.border),
                        ),
                      ]),
                      TableRow(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Ngôn ngữ',
                            textAlign: TextAlign.end,
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.borderTrip),
                          ),
                        ),
                        Text(
                          convertLanguageCode(film.languageCode),
                          style: textTheme.bodyText2
                              .copyWith(color: AppColor.border),
                        ),
                      ]),
                    ],
                  ),
                ),
                Image.asset('assets/divider.png'),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 360 * 16,
                      vertical: screenHeight / 667 * 8),
                  child: Text(
                    film.introduction,
                    style: textTheme.bodyText2.copyWith(
                      color: AppColor.border,
                    ),
                  ),
                )
              ],
            ),
          ) else Container(),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không load được $url';
    }
  }

  Widget _filmInfo(BuildContext context, Film film) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<String> version = film.versionCode.split('/');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: screenWidth / 11 * 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  film.filmName.substring(0, film.filmName.indexOf('-')),
                  style: textTheme.bodyText2.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                ),
                Container(
                  height: screenHeight / 667 * 8,
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
                Container(
                  height: screenHeight / 667 * 8,
                ),
                Text(
                  film.duration.toString() +
                      'p'
                          ' - ' +
                      film.premieredDay
                          .substring(0, film.premieredDay.indexOf('T')),
                  style:
                      textTheme.bodyText2.copyWith(color: AppColor.borderTrip),
                ),
              ],
            ),
          ),
          AVButtonFill(
              title: 'ĐẶT VÉ',
              onPressed: () {
                print('abc');
              })
        ],
      ),
    );
  }
}