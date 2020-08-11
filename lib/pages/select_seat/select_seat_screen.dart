import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/pages/select_seat/select_seat_bloc.dart';

class SelectSeatPage extends StatefulWidget {
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  SelectSeatBloc bloc = SelectSeatBloc();

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
          return _showSeat(context);
        } else if (state is FailToReceiveSeatDataSelectSeatState) {}

        return Container();
      },
    );
  }

  Widget _showSeat(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
        ],
      ),
    );
  }
}
