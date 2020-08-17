import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
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

//  final int sessionId2 = 246813; //246773 //204907 //246844 //246840 //246813

  @override
  void initState() {
    bloc.add(
        GetSeatDataSelectSeatEvent(widget.session.id, _totalPrice(chosenSeatList), chosenSeatList)); //204907  , 246773
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
            icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context, RoutesName.filmSchedulePage)),
        elevation: 0.0,
        title: const Text('Chọn ghế'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              width: (screenWidth * 264) / 360,
              child: Image.asset(
                'assets/screen.png',
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

  Widget _showError(BuildContext context, FailToReceiveSeatDataSelectSeatState state) {
    return Column(children: <Widget>[
      Text(
        state.errorMessage,
        style: const TextStyle(color: AppColor.white),
      ),
      RaisedButton(
        color: AppColor.red100,
        onPressed: () {
          bloc.add(GetSeatDataSelectSeatEvent(widget.session.id, _totalPrice(chosenSeatList), chosenSeatList));
        },
      ),
    ]);
  }

  Widget _showSeat(BuildContext context, ReceiveSeatDataSelectSeatState state) {
    final List<Seat> seatList = state.seatList;
    final int maximumColumn = findMaxColumn(state.seatList) + 1;

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
          image: AssetImage('assets/line1.png'),
        ),
        Container(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: <Widget>[
            Text(
              widget.film.filmName,
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: AppColor.white),
            ),
            Container(),
          ]),
        ),
        Container(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  state.chosenList.length.toString(),
                  style: const TextStyle(color: AppColor.white),
                ),
                const Text(
                  ' ghế - ',
                  style: TextStyle(color: AppColor.white),
                ),
                Text(
                  currencyFormat(state.totalPrice.toInt(), 'VND'),
                  style: const TextStyle(color: AppColor.white),
                ),
              ],
            ),
            AVButtonFill(
              title: 'ĐẶT VÉ',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.checkOutPage,
                  arguments: <String, dynamic>{
                    Constant.chosenList: state.chosenList,
                    Constant.session: widget.session,
                    Constant.film: widget.film,
                  },
                );
              },
            ),
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
      if (seat.code == s.code) {
        return _selectSeatContainer(
          context: context,
          seat: seat,
          chosenList: chosenList,
          seatList: seatList,
          color: AppColor.white,
        );
      }
    }

    if (seat.type == SeatType.path) {
      return Container();
    }
    if (seat.status == 1 || seat.status == 2) {
      return _soldSeatContainer(context: context, color: AppColor.dark60, seat: seat);
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
  }) {
    return Container(
      child: GestureDetector(
        //child: Text(seat.code + '-${seat.rows} + ${seat.column}',style: const TextStyle(color: AppColor.blue),),
        onTap: () {
          const bool check = true;
          checkValidSeat(chosenList, seat, check);
          bloc.add(UpdateSeatDataSelectSeatEvent(seatList, _totalPrice(chosenList), chosenList));
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
    );
  }

  Widget _selectSeatContainer({
    @required BuildContext context,
    @required Color color,
    @required Seat seat,
    @required List<Seat> chosenList,
    @required List<Seat> seatList,
  }) {
    return Container(
      child: GestureDetector(
        child: const Center(
          child: Icon(
            Icons.check,
            color: AppColor.green,
          ),
        ),
        onTap: () {
          const bool check = true;
          checkValidSeat(chosenList, seat, check);
          bloc.add(UpdateSeatDataSelectSeatEvent(seatList, _totalPrice(chosenList), chosenList));
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
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
          style: Theme
              .of(context)
              .textTheme
              .subtitle2
              .copyWith(color: AppColor.white),
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
