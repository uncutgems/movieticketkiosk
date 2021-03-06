import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/enum.dart';
import 'package:ncckios/pages/select_seat/select_seat_bloc.dart';
import 'package:ncckios/widgets/button/button_widget.dart';
import 'package:ncckios/widgets/container/language_code_widget.dart';
import 'package:ncckios/widgets/container/version_code_container.dart';
import 'package:ncckios/widgets/faling_widget/failing_widget.dart';

import '../../model/entity.dart';

class SelectSeatPage extends StatefulWidget {
  const SelectSeatPage({
    Key key,
    @required this.film,
    @required this.session,
  }) : super(key: key);

  final Film film;
  final Session session;

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  SelectSeatBloc bloc = SelectSeatBloc();
  List<Seat> chosenSeatList = <Seat>[];
  // List<Seat> checkChosenSeatList = <Seat>[];
  List<Seat> coupleSeatList = <Seat>[];

//  final int sessionId2 = 246813; //246773 //204907 //246844 //246840 //246813

  @override
  void initState() {
    bloc.add(GetSeatDataSelectSeatEvent(
        widget.session.id,
        // 204907,
        _totalPrice(chosenSeatList),
        chosenSeatList)); //204907  , 246773
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Widget _loading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: AppSize.getWidth(context, 20),
            ),
            onPressed: () =>
                Navigator.pop(context, RoutesName.filmSchedulePage)),
        elevation: 0.0,
        title: Text(
          'Ch???n gh???',
          style: textTheme.bodyText1.copyWith(
            color: AppColor.dark20,
            fontWeight: FontWeight.w500,
            fontSize: AppSize.getFontSize(context, 20),
          ),
        ),
        centerTitle: true,
        toolbarHeight: AppSize.getWidth(context, 48),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              width: AppSize.getWidth(context, 264),
              child: Image.asset(
                'assets/screen2.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          BlocBuilder<SelectSeatBloc, SelectSeatState>(
            cubit: bloc,
            builder: (BuildContext context, SelectSeatState state) {
              print(state);
              if (state is LoadSeatDataSelectSeatState) {
                return _loading(context);
              } else if (state is ReceiveSeatDataSelectSeatState) {
                coupleSeatList = countCoupleSeat(state.seatList);
                return _showSeat(context, state, chosenSeatList);
              } else if (state is FailToReceiveSeatDataSelectSeatState) {
                return FailingWidget(
                  errorMessage: state.errorMessage,
                  onPressed: () {
                    bloc.add(GetSeatDataSelectSeatEvent(
                        widget.session.id,
                        //204907,
                        _totalPrice(chosenSeatList),
                        chosenSeatList));
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _showSeat(BuildContext context, ReceiveSeatDataSelectSeatState state, List<Seat> chosenList) {
    final List<Seat> seatList = state.seatList;
    final int maximumColumn = findMaxColumn(state.seatList) + 1;
    return Column(
      children: <Widget>[
        /*    V??? r???p     */
        Padding(
          padding:
              EdgeInsets.only(right: AppSize.getWidth(context, 15), bottom: 4),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: maximumColumn,
            children: seatList.map((Seat seat) {
              return _seatByType(
                context: context,
                seat: seat,
                chosenList: chosenList,
                maximum: maximumColumn,
                seatList: state.seatList,
                coupleSeatList: coupleSeatList,
              );
            }).toList(),
          ),
        ),
        Container(
          height: AppSize.getWidth(context, 24),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: AppSize.getWidth(context, 16),
              right: AppSize.getWidth(context, 16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _demoSeat(
                context: context,
                color: AppColor.dark60,
                text: '???? ?????t',
              ),
              _demoSeat(
                context: context,
                color: AppColor.white,
                text: '??ang ch???n',
                check: true,
              ),
              _demoSeat(
                context: context,
                color: Colors.transparent,
                text: '',
              ),
            ],
          ),
        ),
        Container(
          height: AppSize.getWidth(context, 8),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: AppSize.getWidth(context, 16),
              right: AppSize.getWidth(context, 16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _demoSeat(
                context: context,
                color: AppColor.white,
                text: 'Gh??? th?????ng',
              ),
              _demoSeat(
                context: context,
                color: AppColor.orange80,
                text: 'Gh??? Vip',
              ),
              _demoSeat(
                context: context,
                color: AppColor.red100,
                text: 'Gh??? ????i',
              ),
            ],
          ),
        ),
        Container(
          height: AppSize.getWidth(context, 32),
        ),
        const Image(
          image: AssetImage('assets/line2.png'),
        ),
        Container(
          height: AppSize.getWidth(context, 8),
        ),
        Padding(
          padding: EdgeInsets.only(left: AppSize.getWidth(context, 16)),
          child: Row(
            children: <Widget>[
              Text(
                widget.film.filmName,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: AppColor.white),
              ),
            ],
          ),
        ),
        Container(),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Row(
            children: <Widget>[
              VersionCodeContainer(
                context: context,
                versionCode: widget.session.versionCode,
              ),
              Container(
                width: AppSize.getWidth(context, 4),
              ),
              LanguageCodeContainer(
                languageCode: widget.session.languageCode,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      state.chosenList.length.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: AppColor.white),
                    ),
                    Text(
                      ' gh??? - ',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: AppColor.white),
                    ),
                    Text(
                      currencyFormat(state.totalPrice.toInt(), 'VND'),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: AppColor.white),
                    ),
                  ],
                ),
                AVButtonFill(
                    width: AppSize.getWidth(context, 117),
                    height: AppSize.getWidth(context, 48),
                    title: '?????T V??',
                    onPressed: () {
                      if (state.chosenList.isEmpty) {
                        showMaterialDialog(
                          context: context,
                          title: 'B???n ch??a ch???n gh??? n??o!',
                          content: 'Vui L??ng ch???n gh??? ????? ti???p t???c',
                          action: <Widget>[
                            FlatButton(
                              child: Text(
                                'Ch???n gh???!',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      color: AppColor.blue,
                                      fontSize:
                                          AppSize.getFontSize(context, 12),
                                    ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      } else if (checkChosenList(state.chosenList)) {
                        Navigator.pushNamed(
                          context,
                          RoutesName.checkOutPage,
                          arguments: <String, dynamic>{
                            Constant.chosenList: state.chosenList,
                            Constant.session: widget.session,
                            Constant.film: widget.film,
                          },
                        );
                      } else {
                        showMaterialDialog(
                          context: context,
                          content: 'Vui L??ng kh??ng ????? gh??? tr???ng ??? gi???a',
                          action: <Widget>[
                            FlatButton(
                              child: Text('Ch???n l???i!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color: AppColor.white, fontSize: 17)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                    }),
              ]),
        ),
      ],
    );
  }

  Widget _seatByType({
    @required BuildContext context,
    @required Seat seat,
    @required List<Seat> chosenList,
    @required List<Seat> seatList,
    @required int maximum,
    @required List<Seat> coupleSeatList,
  }) {
    for (final Seat s in chosenList) {
      if (seat.code == s.code && seat.type == SeatType.vipSeat) {
        return _seatContainer(
          context: context,
          seat: seat,
          chosenList: chosenList,
          seatList: seatList,
          color: AppColor.orange80,
          checker: true,
        );
      } else if (seat.code == s.code && seat.type == SeatType.coupleSeat) {
        return coupleSeatContainer(
          context: context,
          seat: seat,
          chosenList: chosenList,
          seatList: seatList,
          color: AppColor.red,
          checker: true,
          coupleSeatList: coupleSeatList,
        );
      } else if (seat.code == s.code && seat.type == SeatType.normalSeat) {
        return _seatContainer(
          context: context,
          seat: seat,
          chosenList: chosenList,
          seatList: seatList,
          color: AppColor.white,
          checker: true,
        );
      }
    }

    if (seat.type == SeatType.path) {
      return Container();
    }
    if (seat.status == 1) {
      return _soldSeatContainer(
          context: context, color: AppColor.dark60, seat: seat);
    } else if (seat.type == SeatType.vipSeat) {
      return _seatContainer(
        context: context,
        color: AppColor.orange80,
        seat: seat,
        chosenList: chosenList,
        seatList: seatList,
      );
    } else if (seat.type == SeatType.coupleSeat) {
      return coupleSeatContainer(
        context: context,
        color: AppColor.red100,
        seat: seat,
        chosenList: chosenList,
        seatList: seatList,
        coupleSeatList: coupleSeatList,
      );
    } else if (seat.type == SeatType.numberTheSeat && seat.column == 0) {
      return Container();
    } else if (seat.type == SeatType.numberTheSeat) {
      return _numberSeatContainer(context: context, seat: seat);
    } else if (seat.type == SeatType.alphabetSeat) {
      return _alphabetSeatContainer(context: context, seat: seat);
    } else {
      return _seatContainer(
        context: context,
        color: AppColor.white,
        chosenList: chosenList,
        seat: seat,
        seatList: seatList,
      );
    }
  }

  Widget _seatContainer({
    @required BuildContext context,
    @required Color color,
    @required Seat seat,
    @required List<Seat> chosenList,
    @required List<Seat> seatList,
    bool checker,
  }) {
    return AnimatedContainer(
      child: GestureDetector(
        child: checker ?? false
            ? const Icon(
                Icons.check,
                color: AppColor.black,
              )
            : null,
//        child: Text(
//          '${seat.rows} - ${seat.column}',
//          style: const TextStyle(color: AppColor.blue),
//        ),
        onTap: () {
          const bool check = true;
          checkValidSeat(chosenList, seat, check);
          bloc.add(UpdateSeatDataSelectSeatEvent(
              seatList, _totalPrice(chosenList), chosenList));
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      duration: const Duration(milliseconds: 100),
    );
  }

  Widget coupleSeatContainer({
    @required BuildContext context,
    @required Color color,
    @required Seat seat,
    @required List<Seat> chosenList,
    @required List<Seat> seatList,
    @required List<Seat> coupleSeatList,
    bool checker,
  }) {
    print('Hello======' + coupleSeatList.length.toString());
    print('HIIIIIII  ${coupleSeatList.first.column} ');
    print('HIIIIIII  ${coupleSeatList.last.column} ');
    return AnimatedContainer(
      child: GestureDetector(
        child: checker ?? false
            ? const Icon(
                Icons.check,
                color: AppColor.black,
              )
            : null,
        onTap: () {
          const bool check = true;
          checkCoupleSeatValidSeat(
              chosenList, seat, check, seatList, coupleSeatList);
          bloc.add(UpdateSeatDataSelectSeatEvent(
              seatList, _totalPrice(chosenList), chosenList));
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      duration: const Duration(milliseconds: 100),
    );
  }

  Widget _soldSeatContainer({
    @required BuildContext context,
    @required Color color,
    @required Seat seat,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
    );
  }

  Widget _numberSeatContainer({
    @required BuildContext context,
    @required Seat seat,
  }) {
    return Container(
      child: Center(
          child: Text(
        seat.code,
        style: const TextStyle(color: AppColor.white),
      )),
    );
  }

  Widget _alphabetSeatContainer({
    @required BuildContext context,
    @required Seat seat,
  }) {
    return Container(
      child: Center(
          child: Text(
        String.fromCharCode(seat.rows + 65),
        style: const TextStyle(color: AppColor.white),
      )),
    );
  }

  Widget _demoSeat({
    @required BuildContext context,
    @required Color color,
    @required String text,
    bool check,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: AppSize.getWidth(context, 26),
          height: AppSize.getWidth(context, 26),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.getWidth(context, 4)),
            color: color,
          ),
          child: check ?? false
              ? const Icon(
                  Icons.check,
                  color: AppColor.red,
                )
              : null,
        ),
        Text(
          text,
          maxLines: 2,
          style: textTheme.subtitle2.copyWith(
              color: AppColor.white,
              fontSize: AppSize.getFontSize(context, 14)),
        ),
      ],
    );
  }

  List<Seat> countCoupleSeat(List<Seat> seatList) {
    final List<Seat> result = <Seat>[];
    for (final Seat seat in seatList) {
      if (seat.type == SeatType.coupleSeat) {
        result.add(seat);
      }
    }
    return result;
  }
}

int findMaxColumn(List<Seat> myList) {
  int maxColumnNumber;
  if (myList != null && myList.isNotEmpty) {
    maxColumnNumber = myList.map<int>((Seat e) => e.column ?? 0).reduce(max);
  }
  return maxColumnNumber;
}

int findMaxRow(List<Seat> myList) {
  int maxColumnNumber;
  if (myList != null && myList.isNotEmpty) {
    maxColumnNumber = myList.map<int>((Seat e) => e.rows ?? 0).reduce(max);
  }
  return maxColumnNumber;
}

void checkValidSeat(List<Seat> chosenList, Seat seat, bool check) {
  bool check = false;
  if (chosenList.isNotEmpty) {
    for (final Seat s in chosenList) {
      if (seat.code == s.code) {
        check = true;
      }
    }
    if (!check) {
      chosenList.add(seat);
    } else if (check) {
      chosenList.remove(seat);
    }
  } else {
    chosenList.add(seat);
  }
  print(seat.code);
  print('$chosenList');
  print(_totalPrice(chosenList));
}

void checkCoupleSeatValidSeat(List<Seat> chosenList, Seat seat, bool check,
    List<Seat> seatList, List<Seat> coupleSeatList) {
  bool check = false;
  if (chosenList.isNotEmpty) {
    for (final Seat s in chosenList) {
      if (seat.rows == s.rows && seat.column == s.column) {
        check = true;
      }
    }
    if (!check) {
      if (coupleSeatList.first.column.isEven) {
        if (seat.column.isEven) {
          chosenList.add(seat);
          chosenList.add(seatList[(seatList.indexOf(seat) + 1)]);
        } else if (seat.column.isOdd) {
          chosenList.add(seat);
          chosenList.add(seatList[(seatList.indexOf(seat) - 1)]);
        }
      } else {
        if (seat.column.isEven) {
          chosenList.add(seat);
          chosenList.add(seatList[(seatList.indexOf(seat) - 1)]);
        } else if (seat.column.isOdd) {
          chosenList.add(seat);
          chosenList.add(seatList[(seatList.indexOf(seat) + 1)]);
        }
      }
    } else if (check) {
      if (coupleSeatList.first.column.isEven) {
        if (seat.column.isEven) {
          chosenList.remove(seat);
          chosenList.remove(seatList[(seatList.indexOf(seat) + 1)]);
        } else if (seat.column.isOdd) {
          chosenList.remove(seat);
          chosenList.remove(seatList[(seatList.indexOf(seat) - 1)]);
        }
      } else {
        if (seat.column.isEven) {
          chosenList.remove(seat);
          chosenList.remove(seatList[(seatList.indexOf(seat) - 1)]);
        } else if (seat.column.isOdd) {
          chosenList.remove(seat);
          chosenList.remove(seatList[(seatList.indexOf(seat) + 1)]);
        }
      }
    }
  } else {
    if (coupleSeatList.first.column.isEven) {
      if (seat.column.isEven) {
        chosenList.add(seat);
        chosenList.add(seatList[(seatList.indexOf(seat) + 1)]);
      } else if (seat.column.isOdd) {
        chosenList.add(seat);
        chosenList.add(seatList[(seatList.indexOf(seat) - 1)]);
      }
    } else {
      if (seat.column.isEven) {
        chosenList.add(seat);
        chosenList.add(seatList[(seatList.indexOf(seat) - 1)]);
      } else if (seat.column.isOdd) {
        chosenList.add(seat);
        chosenList.add(seatList[(seatList.indexOf(seat) + 1)]);
      }
    }
  }
  print(seat.code);
  print('$chosenList');
  print(_totalPrice(chosenList));
}

double _totalPrice(List<Seat> chosenList) {
  double totalPrice = 0;
  if (chosenList.isNotEmpty && chosenList != null) {
    for (final Seat chosenSeat in chosenList) {
      totalPrice = chosenSeat.price + totalPrice;
    }
  }
  return totalPrice;
}

bool checkChosenList(List<Seat> chosenList) {
  final Map<int, List<int>> map = <int, List<int>>{};
  final Comparator<int> comparator = (int a, int b) => a.compareTo(b);
  for (final Seat seat in chosenList) {
    map.putIfAbsent(seat.rows, () => <int>[]);
    print('========${seat.rows}');

    map[seat.rows].add(seat.column);
  }
  for (final int row in map.keys) {
    map[row].sort(comparator);
  }

  bool check = true;
  print('=======$map');
  for (final int row in map.keys) {
    for (int i = 0; i < map[row].length - 1; i++) {
      if ((map[row][i] - map[row][i + 1]).abs() == 2) {
        check = false;
      }
    }
  }

  return check;
}
