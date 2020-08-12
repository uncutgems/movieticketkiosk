import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/pages/select_seat/select_seat_bloc.dart';

import '../../model/entity.dart';

class SelectSeatPage extends StatefulWidget {
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  SelectSeatBloc bloc = SelectSeatBloc();
  List<Seat> finalSeatList;

  @override
  void initState() {
    bloc.add(GetSeatDataSelectSeatEvent(204907));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectSeatBloc, SelectSeatState>(
      cubit: bloc,
      builder: (BuildContext context, SelectSeatState state) {
        print(state);
        if (state is ReceiveSeatDataSelectSeatState) {
          return _showSeat(context, state);
        } else if (state is FailToReceiveSeatDataSelectSeatState) {}

        return Container();
      },
    );
  }

  Widget _showSeat(BuildContext context, ReceiveSeatDataSelectSeatState state) {
    int y = 0;
    int z = 0;
    final List<Seat> seatList = state.seatList;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int maximumColumn = findMaxColumn(state.seatList) + 1;
    final int maximumRow = findMaxRow(state.seatList) + 1;
    final int area = maximumColumn * maximumRow;
    final Seat dummySeat = Seat(type: '-1');

    for (int i = 0; i < seatList.length; i++) {
      if (seatList[i].column == maximumColumn-1) {
        seatList.insert(i, dummySeat);
        i++;
      }
    }

    for (int i = 0; i < maximumColumn + 1; i++) {
      seatList.insert(i, dummySeat);
    }

    print(maximumColumn);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Chọn ghế'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 18.98,
          ),
          Center(
            child: Container(
              width: (screenWidth * 264) / 360,
              child: Image.asset(
                'assets/screen.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: maximumColumn),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: maximumColumn,
              itemBuilder: (BuildContext context, int index) => Container(
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(color: AppColor.white),
                  ),
                ),
              ),
            ),
          ),

//          ListView.builder(
//            shrinkWrap: true,
//            physics: const NeverScrollableScrollPhysics(),
//            itemCount: maximumRow,
//            itemBuilder: (BuildContext context, int index) => Container(
//              child: Center(
//                child: Text(
//                  String.fromCharCode(index + 65),
//                  style: const TextStyle(color: AppColor.white),
//                ),
//              ),
//            ),
//          ),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: maximumColumn +1 ,
              children: seatList.map((Seat e) {
                if (e.type == '12') {
                  return Container();
                } else if (e.type == '1') {
                  return _seatContainer(
                      context: context, color: AppColor.orange80);
                } else if (e.type == '2') {
                  return _coupleSeatContainer(
                      context: context, color: AppColor.red100);
                } else if (e.type == '-1') {
                  return _seatContainer(
                      context: context, color: Colors.green);
                } else {
                  return _seatContainer(
                      context: context, color: AppColor.white);
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  int findMaxColumn(List<Seat> myList) {
    int maxColumnNumber;
    if (myList != null && myList.isNotEmpty) {
      maxColumnNumber = myList.map<int>((e) => e.column).reduce(max);
    }
    return maxColumnNumber;
  }

  int findMaxRow(List<Seat> myList) {
    int maxColumnNumber;
    if (myList != null && myList.isNotEmpty) {
      maxColumnNumber = myList.map<int>((e) => e.rows).reduce(max);
    }
    return maxColumnNumber;
  }

  Widget _seatContainer({
    @required BuildContext context,
    @required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
    );
  }

  Widget _coupleSeatContainer({
    @required BuildContext context,
    @required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
    );
  }
}
