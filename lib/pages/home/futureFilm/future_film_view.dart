import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/home/futureFilm/future_film_bloc.dart';
import 'package:ncckios/widgets/container/version_code_container.dart';
import 'package:ncckios/widgets/loading/loading_widget.dart';

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
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FutureFilmBloc, FutureFilmState>(
        cubit: bloc,
        builder: (BuildContext context, FutureFilmState state) {
          if (state is SuccessGetDataFutureFilmState) {
            return _body(context, state);
          } else if (state is FailGetDataFutureFilmState) {
            return _failToLoad(context, state);
          } else {
            return Container();
          }
        },
        buildWhen: (FutureFilmState prev, FutureFilmState current) {
          if (current is NavigateDetailFutureFilmState) {
            _navigateToDetail(context, current);
            return false;
          } else {
            return true;
          }
        });
  }

  Widget _body(BuildContext context, SuccessGetDataFutureFilmState state) {
    final List<Film> futureFilmList = state.listFilm;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.getWidth(context, 16)),
      child: Container(
        height: AppSize.getHeight(context, 350),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final Film futureFilm = futureFilmList[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      futureFilm.id == null
                          ? print('not yet')
                          : bloc.add(ClickToDetailFutureFilmEvent(futureFilm.id));

                    },
                    child: Container(
                        width: AppSize.getWidth(context, 160),
                        height: AppSize.getHeight(context, 240),
                        decoration: filmBoxDecoration.copyWith(
                            color: AppColor.primaryDarkColor,
                            image: futureFilm.imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(futureFilm.imageUrl),
                                    fit: BoxFit.cover,
                                  )
                                : null),
                        child: futureFilm.id == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : null),
                  ),
                  Container(
                    height: AppSize.getHeight(context, 8),
                  ),
                  Container(
                    width: AppSize.getWidth(context, 163),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (futureFilm.id != null)
                          SizedBox(
                            child: Text(
                              futureFilm.filmName.substring(
                                  0, futureFilm.filmName.indexOf('-')),
                              style: textTheme.bodyText2.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppSize.getFontSize(context, 16)),
                              maxLines: 2,
                            ),
                          )
                        else
                          Container(),
                        Container(
                          height: AppSize.getHeight(context, 8),
                        ),
                        if (futureFilm.id != null)
                          Container(
                            height: AppSize.getHeight(context, 22),
                            width: AppSize.getWidth(context, 36),
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Container(
                                          width: AppSize.getWidth(context, 4)),
                              itemCount:
                                  futureFilm.versionCode.split('/').length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final List<String> version =
                                    futureFilm.versionCode.split('/');
                                final String versionCode = version[index];
                                return
//                                  Container(
//                                  padding: EdgeInsets.symmetric(
//                                      vertical: AppSize.getHeight(context, 3),
//                                      horizontal: AppSize.getWidth(context, 4)),
//                                  child: Center(
//                                    child: Text(
//                                      versionCode,
//                                      style: textTheme.bodyText2.copyWith(
//                                          color: AppColor.red,
//                                          fontSize:
//                                              AppSize.getFontSize(context, 14)),
//                                    ),
//                                  ),
//                                  decoration: BoxDecoration(
//                                    color: AppColor.backGround,
//                                    borderRadius: BorderRadius.circular(4),
//                                    border: Border.all(
//                                        width: AppSize.getWidth(context, 1),
//                                        color: AppColor.red,
//                                        style: BorderStyle.solid),
//                                  ),
//                                );
                                    VersionCodeContainer(
                                  context: context,
                                  versionCode: versionCode,
                                );
                              },
                            ),
                          )
                        else
                          Container(),
                        Container(
                          height: AppSize.getHeight(context, 8),
                        ),
                        if (futureFilm.id != null)
                          Text(
                            '${futureFilm.duration.toString()}p  - ${convertTime('dd/MM/yyyy', DateTime.parse(futureFilm.premieredDay).millisecondsSinceEpoch, false)}',
                            style: textTheme.bodyText2.copyWith(
                                color: AppColor.borderTrip,
                                fontSize: AppSize.getFontSize(context, 14)),
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: AppSize.getWidth(context, 16),
                ),
            itemCount: futureFilmList.length),
      ),
    );
  }

  void _navigateToDetail(
      BuildContext context, NavigateDetailFutureFilmState state) {
    Navigator.pushNamed(context, RoutesName.detailPage, arguments: <String, dynamic> {
      Constant.filmId: state.id , Constant.isPlayNow : false,
    });
  }

  Widget _failToLoad(BuildContext context, FailGetDataFutureFilmState state) {
    return Container(
      height: AppSize.getHeight(context, 310),
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
              height: AppSize.getHeight(context, 8),
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: AppSize.getHeight(context, 36),
              ),
              onPressed: () {
                bloc.add(GetDataFutureFilmEvent());
              },
            )
          ],
        ),
      ),
    );
  }
}
