import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/enum.dart';
import 'package:ncckios/pages/select_seat/select_seat_bloc.dart';
import 'package:ncckios/widgets/button/button_widget.dart';

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
  List<Seat> checkChosenSeatList = <Seat>[];

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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pop(context, RoutesName.filmSchedulePage)),
        elevation: 0.0,
        title: const Text('Chọn ghế'),
        centerTitle: true,
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
                return _showSeat(context, state);
              } else if (state is FailToReceiveSeatDataSelectSeatState) {
                _showError(context, state);
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _showError(
      BuildContext context, FailToReceiveSeatDataSelectSeatState state) {
    return Column(children: <Widget>[
      Text(
        state.errorMessage,
        style: const TextStyle(color: AppColor.white),
      ),
      RaisedButton(
        color: AppColor.red100,
        onPressed: () {
          bloc.add(GetSeatDataSelectSeatEvent(
              widget.session.id,
              //204907,
              _totalPrice(chosenSeatList),
              chosenSeatList));
        },
      ),
    ]);
  }

  Widget _showSeat(BuildContext context, ReceiveSeatDataSelectSeatState state) {
    final List<Seat> seatList = state.seatList;
    final int maximumColumn = findMaxColumn(state.seatList) + 1;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        /*    Vẽ rạp     */
        Padding(
          padding: const EdgeInsets.only(right: 15, bottom: 4),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: maximumColumn,
            children: seatList.map((Seat seat) {
              return _seatByType(
                context: context,
                seat: seat,
                chosenList: chosenSeatList,
                maximum: maximumColumn,
                seatList: state.seatList,
              );
            }).toList(),
          ),
        ),
        Container(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _demoSeat(
                  context: context,
                  color: AppColor.dark60,
                  text: 'Đã đặt',
                ),
              ),
              Expanded(
                child: _demoSeat(
                  context: context,
                  color: AppColor.white,
                  text: 'Đang chọn',
                  check: true,
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        Container(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 32),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _demoSeat(
                  context: context,
                  color: AppColor.white,
                  text: 'Ghế thường',
                ),
              ),
              Expanded(
                child: _demoSeat(
                  context: context,
                  color: AppColor.orange80,
                  text: 'Ghế Vip',
                ),
              ),
              Expanded(
                child: _demoSeat(
                  context: context,
                  color: AppColor.red100,
                  text: 'Ghế Đôi',
                ),
              ),
            ],
          ),
        ),
        const Image(
          image: AssetImage('assets/line2.png'),
        ),
        Container(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: <Widget>[
            Text(
              widget.film.filmName,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: AppColor.white),
            ),
            Container(),
          ]),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Row(
            children: <Widget>[
              Container(
                width: AppSize.getWidth(context, 26),
                height: AppSize.getHeight(context, 22),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColor.red)),
                child: Center(
                  child: Text(
                    widget.session.versionCode,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 18, color: AppColor.red),
                  ),
                ),
              ),
              Container(
                width: AppSize.getWidth(context, 4),
              ),
              Container(
                width: AppSize.getWidth(context, 26),
                height: AppSize.getHeight(context, 22),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColor.red)),
                child: Center(
                  child: Text(
                    widget.session.languageCode,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 18, color: AppColor.red),
                  ),
                ),
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
                      ' ghế - ',
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
                    height: AppSize.getHeight(context, 48),
                    title: 'ĐẶT VÉ',
                    onPressed: () {
                      if (state.chosenList.isEmpty) {
                        showMaterialDialog(
                          context: context,
                          title: 'Bạn chưa chọn ghế nào!',
                          content: 'Vui Lòng chọn ghế để tiếp tục',
                          action: <Widget>[
                            FlatButton(
                              child: Text('Chọn ghế!',
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
                          content: 'Vui Lòng không để ghế trống ở giữa',
                          action: <Widget>[
                            FlatButton(
                              child: Text('Chọn lại!',
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
        return _seatContainer(
          context: context,
          seat: seat,
          chosenList: chosenList,
          seatList: seatList,
          color: AppColor.red,
          checker: true,
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
      return _seatContainer(
          context: context,
          color: AppColor.red100,
          seat: seat,
          chosenList: chosenList,
          seatList: seatList);
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
                color: AppColor.green,
              )
            : null,
        //child: Text(seat.code + '-${seat.rows} + ${seat.column}',style: const TextStyle(color: AppColor.blue),),
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

  Widget _soldSeatContainer({
    @required BuildContext context,
    @required Color color,
    @required Seat seat,
  }) {
    return Container(
      //child: Text(seat.code + '-${seat.rows} + ${seat.column}',style: const TextStyle(color: AppColor.blue),),
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: AppSize.getWidth(context, 26),
          height: AppSize.getWidth(context, 26),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
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
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: AppColor.white, fontSize: 18),
        ),
      ],
    );
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
