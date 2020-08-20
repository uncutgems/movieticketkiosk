import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/widgets/button/button_widget.dart';
import 'package:ncckios/widgets/ticket/ticket_widget.dart';

class SuccessfulCheckoutPage extends StatefulWidget {
  const SuccessfulCheckoutPage(
      {Key key,
      @required this.film,
      @required this.session,
      @required this.seats,
      this.customerFirstName,
      this.customerLastName})
      : super(key: key);

  final Film film;
  final Session session;
  final List<Seat> seats;
  final String customerFirstName;
  final String customerLastName;

  @override
  _SuccessfulCheckoutPageState createState() => _SuccessfulCheckoutPageState();
}

class _SuccessfulCheckoutPageState extends State<SuccessfulCheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: AppSize.getHeight(context, 48),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: AppSize.getHeight(context, 20),
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'Thanh toán',
          style: Theme
              .of(context)
              .textTheme
              .bodyText2
              .copyWith(color: AppColor.white, fontSize: AppSize.getFontSize(context, 20)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Center(
            child: Text(
              'Thanh toán thành công!',
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(
                color: AppColor.white,
                fontSize: AppSize.getFontSize(context, 16),
              ),
            ),
          ),
          Container(height: 24 / 667 * _screenHeight),
          TicketWidget(
            orderId: null,
            name: widget.customerLastName + ' ' + widget.customerFirstName,
            seat: convertSeatToString(widget.seats),
            version: widget.film.versionCode,
            languageCode: widget.film.languageCode,
            projectDate:
            convertTime('dd/MM/yyy', DateTime
                .parse(widget.session.projectDate)
                .millisecondsSinceEpoch, false),
            projectTime: convertTime('hh:mm', DateTime
                .parse(widget.session.projectTime)
                .millisecondsSinceEpoch, false),
            cinemaId: widget.session.roomName,
            filmName: widget.film.filmName,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AVButtonFill(
          title: 'về trang chủ',
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName(RoutesName.homePage));
          },
        ),
      ),
    );
  }

  String convertSeatToString(List<Seat> seatList) {
    String result = '';
    for (final Seat seat in seatList) {
      result += seat.code + ',';
    }
    result = result.substring(0, result.length - 1);
    print(result);

    return result;
  }
}
