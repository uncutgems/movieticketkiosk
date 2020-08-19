import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/detail/detail_bloc.dart';
import 'package:ncckios/widgets/button/button_widget.dart';
import 'package:ncckios/widgets/container/version_code_container.dart';
import 'package:ncckios/widgets/loading/loading_widget.dart';
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
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: AppSize.getHeight(context, 20),
            ),
            onPressed: () =>
                Navigator.pop(context, RoutesName.filmSchedulePage)),
        elevation: 0.0,
        title: Text(
          'Thông tin phim',
          style: textTheme.bodyText1.copyWith(
            color: AppColor.dark20,
            fontWeight: FontWeight.w500,
            fontSize: AppSize.getFontSize(context, 16),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        cubit: bloc,
        builder: (BuildContext context, DetailState state) {
          if (state is LoadingDataDetailState) {
            return LoadingWidget();
          }
          else if (state is SuccessGetDataDetailState) {
            return _body(context, state);
          } else if (state is FailGetDataDetailState) {
            return _failToLoad(context, state);
          } else {
            return Container();
          }
        },
      ),
    );


  }

  Widget _body(BuildContext context, SuccessGetDataDetailState state) {
    final Film film = state.film;
    final EdgeInsets _padding = EdgeInsets.only(
        right: AppSize.getWidth(context, 16),
        top: AppSize.getHeight(context, 8),
        bottom: AppSize.getHeight(context, 8));
    return SafeArea(
      child:  Column(
        children: <Widget>[
          Container(
            height: AppSize.getHeight(context, 327),
            width: AppSize.getWidth(context, 360),
            color: AppColor.white,
            child: Stack(
              children: <Widget>[
                if (film.id != null)
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(film.bannerUrl),
                    )),
                    width: AppSize.getWidth(context, 360),
                    height: AppSize.getHeight(context, 240),
                    child: Center(
                      child: FloatingActionButton(
                        child: const Icon(Icons.play_arrow),
                        elevation: 0.6,
                        onPressed: () {
                          _launchURL(film.videoUrl);
                        },
                      ),
                    ),
                  )
                else
                  Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                            bottom: Radius.circular(0))),
                    width: AppSize.getWidth(context, 360),
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
          if (film.id != null)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.getWidth(context, 16),
                      vertical: AppSize.getHeight(context, 8),
                    ),
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FractionColumnWidth(0.4)
                      },
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            Padding(
                              padding: _padding,
                              child: Text(
                                'Kiểm duỵệt',
                                textAlign: TextAlign.end,
                                style: textTheme.subtitle2.copyWith(
                                    color: AppColor.borderTrip,
                                    fontSize: AppSize.getFontSize(context, 14)),
                              ),
                            ),
                            Padding(
                              padding: _padding,
                              child: Text(
                                film.description,
                                style: textTheme.bodyText2.copyWith(
                                    color: AppColor.border,
                                    fontSize: AppSize.getFontSize(context, 14)),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Padding(
                              padding: _padding,
                              child: Text(
                                'Khởi chiếu',
                                textAlign: TextAlign.end,
                                style: textTheme.subtitle2.copyWith(
                                    color: AppColor.borderTrip,
                                    fontSize: AppSize.getFontSize(context, 14)),
                              ),
                            ),
                            Padding(
                              padding: _padding,
                              child: Text(
                                convertTime(
                                    'dd/MM/yyyy',
                                    DateTime.parse(film.premieredDay)
                                        .millisecondsSinceEpoch,
                                    false),
                                style: textTheme.bodyText2.copyWith(
                                    color: AppColor.border,
                                    fontSize: AppSize.getFontSize(context, 14)),
                              ),
                            ),
                          ],
                        ),
                        TableRow(children: <Widget>[
                          Padding(
                            padding: _padding,
                            child: Text(
                              'Thể loại',
                              textAlign: TextAlign.end,
                              style: textTheme.subtitle2.copyWith(
                                  color: AppColor.borderTrip,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                          Padding(
                            padding: _padding,
                            child: Text(
                              film.category,
                              style: textTheme.bodyText2.copyWith(
                                  color: AppColor.border,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                            padding: _padding,
                            child: Text(
                              'Đạo diễn',
                              textAlign: TextAlign.end,
                              style: textTheme.subtitle2.copyWith(
                                  color: AppColor.borderTrip,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                          Padding(
                            padding: _padding,
                            child: Text(
                              film.director,
                              style: textTheme.bodyText2.copyWith(
                                  color: AppColor.border,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                        ]),
                        TableRow(
                          children: <Widget>[
                            Padding(
                              padding: _padding,
                              child: Text(
                                'Diễn viên',
                                textAlign: TextAlign.end,
                                style: textTheme.subtitle2.copyWith(
                                    color: AppColor.borderTrip,
                                    fontSize: AppSize.getFontSize(context, 14)),
                              ),
                            ),
                            Padding(
                              padding: _padding,
                              child: Text(
                                film.actors,
                                style: textTheme.bodyText2.copyWith(
                                    color: AppColor.border,
                                    fontSize: AppSize.getFontSize(context, 14)),
                              ),
                            ),
                          ],
                        ),
                        TableRow(children: <Widget>[
                          Padding(
                            padding: _padding,
                            child: Text(
                              'Thời lượng',
                              textAlign: TextAlign.end,
                              style: textTheme.subtitle2.copyWith(
                                  color: AppColor.borderTrip,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                          Padding(
                            padding: _padding,
                            child: Text(
                              film.duration.toString() + ' phút',
                              style: textTheme.bodyText2.copyWith(
                                  color: AppColor.border,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                        ]),
                        TableRow(children: <Widget>[
                          Padding(
                            padding: _padding,
                            child: Text(
                              'Ngôn ngữ',
                              textAlign: TextAlign.end,
                              style: textTheme.subtitle2.copyWith(
                                  color: AppColor.borderTrip,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                          Padding(
                            padding: _padding,
                            child: Text(
                              convertLanguageCode(film.languageCode),
                              style: textTheme.bodyText2.copyWith(
                                  color: AppColor.border,
                                  fontSize: AppSize.getFontSize(context, 14)),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Image.asset('assets/divider.png'),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.getWidth(context, 16),
                        vertical: AppSize.getHeight(context, 8)),
                    child: Text(
                      film.introduction,
                      style: textTheme.bodyText2.copyWith(
                          height: 20 / 14,
                          color: AppColor.border,
                          fontSize: AppSize.getFontSize(context, 14)),
                    ),
                  )
                ],
              ),
            )
          else
            Container(),
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
    final List<String> version = film.versionCode.split('/');

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.getWidth(context, 16),
          vertical: AppSize.getHeight(context, 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: AppSize.getWidth(context, 163),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  film.filmName,
                  style: textTheme.bodyText2.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSize.getFontSize(context, 16)),
                  maxLines: 2,
                ),
                Container(
                  height: AppSize.getHeight(context, 8),
                ),
                Container(
                  height: AppSize.getHeight(context, 22),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(width: AppSize.getWidth(context, 4)),
                    itemCount: version.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final String versionCode = version[index];
                      return
//                        Container(
//                        padding: EdgeInsets.symmetric(
//                            vertical: AppSize.getHeight(context, 3),
//                            horizontal: AppSize.getWidth(context, 4)),
//                        child: Center(
//                          child: Text(
//                            versionCode,
//                            style: textTheme.bodyText2.copyWith(
//                                color: AppColor.red,
//                                fontSize: AppSize.getFontSize(context, 14)),
//                          ),
//                        ),
//                        decoration: BoxDecoration(
//                          color: AppColor.backGround,
//                          borderRadius: BorderRadius.circular(4),
//                          border: Border.all(
//                              width: AppSize.getWidth(context, 1),
//                              color: AppColor.red,
//                              style: BorderStyle.solid),
//                        ),
//                      );
                          VersionCodeContainer(
                        context: context,
                        versionCode: versionCode,
                      );
                    },
                  ),
                ),
                Container(
                  height: AppSize.getHeight(context, 8),
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
              title: 'ĐẶT VÉ',
              onPressed: () {
                _navigateToFilmSchedule(context, film);
              })
        ],
      ),
    );
  }

  void _navigateToFilmSchedule(BuildContext context, Film film) {
    Navigator.pushNamed(context, RoutesName.filmSchedulePage,
        arguments: <String, dynamic>{Constant.film: film});
  }

  Widget _failToLoad(BuildContext context, FailGetDataDetailState state) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight / 667 * 330,
      width: screenWidth,
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
              icon: const Icon(
                Icons.refresh,
                size: 36,
              ),
              onPressed: () {
                bloc.add(GetDataDetailEvent(widget.id));
              },
            )
          ],
        ),
      ),
    );
  }
}
