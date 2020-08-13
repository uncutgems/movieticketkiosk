import 'dart:math';

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
    final List<Seat> seatList = state.seatList;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int maximum = findMax(state.seatList) + 1;
    print(maximum);
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
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: maximum,
              children: seatList.map((Seat e) {
                if (e.type == '12') {
                  return Container();
                } else if (e.type == '1') {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4),
                      color: AppColor.orange80,
                    ),
                    //  child: Text(e.code.toString()),
                  );
                }
                else if(e.type == '2'){
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4),

                      color: AppColor.red100,
                    ),
                    //  child: Text(e.code.toString()),
                  );
                }
                else {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4),

                      color: AppColor.white,
                    ),
                    //  child: Text(e.code.toString()),
                  );
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  int findMax(List<Seat> myList) {
    int maxColumnNumber = 18;
    if (myList != null && myList.isNotEmpty) {
      maxColumnNumber = myList.map<int>((e) => e.column).reduce(max);
    }
    return maxColumnNumber;
  }
}
