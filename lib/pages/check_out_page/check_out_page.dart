
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/check_out_page/check_out_bloc.dart';
import 'package:ncckios/widgets/button/button_widget.dart';
import 'package:ncckios/widgets/qr/qr.dart';
import 'package:ncckios/widgets/shortcut/shortcut.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({
    Key key,
    @required this.film,
    @required this.session,
    @required this.seats,
  }) : super(key: key);
  final Film film;
  final Session session;
  final List<Seat> seats;

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage>
    with TickerProviderStateMixin {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  Seat seat = Seat();
  CheckOutBloc bloc = CheckOutBloc();
  AnimationController _animationController;
  int levelClock = 10;

  int orderId;
  @override
  void dispose() {
    _animationController.dispose();
    bloc.close();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutBloc, CheckOutState>(
      cubit: bloc,
      buildWhen: (CheckOutState prev, CheckOutState state) {
        if (state is CheckOutStateTimeOut) {
          _timeOut();
          return false;
        } else {
          return true;
        }
      },
      builder: (BuildContext context, CheckOutState state) {
        if (state is CheckOutInitial) {
          return mainScreen(context, bottomHalf(context));
        } else if (state is CheckOutStateQR) {
          _animationController.forward();
          orderId = state.order.orderId;
          return mainScreen(
            context,
            bottomQR(
              context,
              GestureDetector(
                child: QR(orderId: state.order.orderId),
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesName.successfulCheckout,
                  arguments: <String, dynamic>{
                    Constant.film: widget.film,
                    Constant.session: widget.session,
                    Constant.chosenList: widget.seats,
                    Constant.customerFirstName: firstNameController.text,
                    Constant.customerLastName: lastNameController.text,
                  },
                ),
              ),
            ),
          );
        }
        else if(state is CheckOutStateSuccess){
          Navigator.pushNamed(
            context,
            RoutesName.successfulCheckout,
            arguments: <String, dynamic>{
              Constant.film: widget.film,
              Constant.session: widget.session,
              Constant.chosenList: widget.seats,
              Constant.customerFirstName: firstNameController.text,
              Constant.customerLastName: lastNameController.text,
            },
          );
        }

        return const Material();
      },
    );
  }

  Widget mainScreen(BuildContext context, Widget widget) {
    print(' hello ${this.widget.film.toJson()}');
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 16 * _screenHeight / 720,
            ),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Thanh Toán',
          style: Theme.of(context).textTheme.headline6.copyWith(
              color: AppColor.white,
              fontSize: 16 * _screenHeight / 720,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding:  EdgeInsets.only(top: AppSize.getHeight(context, 8)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  this.widget.film.imageUrl,
                  width: 0.33 * MediaQuery.of(context).size.width,
                  height: 0.27 * MediaQuery.of(context).size.height,
                ),
                Expanded(
                  child: filmInfo(context),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.036,
          ),
          gradientLine(context),
          Container(
            height: MediaQuery.of(context).size.height * 0.036,
          ),
          widget
        ],
      ),
    );
  }

  Widget filmInfo(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.film.filmName,
            style: Theme.of(context).textTheme.headline6.copyWith(
                color: AppColor.white, fontSize: 16 * _screenHeight / 720),
          ),
          Row(
//          mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 24.0, bottom: 16),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColor.red)),
                child: Text(
                  widget.film.versionCode,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14*_screenHeight/720, color: AppColor.red),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, top: 24.0, bottom: 16),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColor.red)),
                child: Text(
                  widget.film.languageCode,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14*_screenHeight/720, color: AppColor.red),
                ),
              ),
            ],
          ),
          Text(
            '•  ${convertTimeToDisplay(widget.session.projectTime)}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 16*_screenHeight/720,
                  color: AppColor.white,
                ),
          ),
          Container(height: 8*_screenHeight/720,),
          Text(
            '•  Phòng chiếu số ${widget.session.roomName}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: 16*_screenHeight/720,
              color: AppColor.white,
            ),
          ),
          Container(height: 8*_screenHeight/720,),
          Text(
            '•  Ghế: ${convertSeatToString(widget.seats)}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 16*_screenHeight/720,
                  color: AppColor.white,
                ),
          ),
          Container(height: 8*_screenHeight/720,),
          Text(
            '•  Tổng cộng: ${currencyFormat(sumOfPrice(widget.seats),'đ')}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: 16*_screenHeight/720,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomHalf(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Center(
          child: Text(
            'Vui lòng nhập thông tin đặt vé',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AppColor.white,fontSize: 16*_screenHeight/720),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * (24 / 667),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: nameBox(context, lastNameController, 'Họ'),
        ),
        Container(
          height: MediaQuery.of(context).size.height * (24 / 667),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: nameBox(context, firstNameController, 'Tên'),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.036,
        ),
        gradientLine(context),
        Container(
          height: MediaQuery.of(context).size.height * (24 / 667),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: InkWell(
            onTap: () =>
                launch('https://chieuphimquocgia.com.vn/t/chinhsachmuave'),
            child: RichText(
              text: TextSpan(
                text: 'Tôi đồng ý với ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: AppColor.white,fontSize: 14*_screenHeight/720),
                children: <TextSpan>[
                  TextSpan(
                      text: 'điều khoản sử dụng',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: AppColor.red,fontSize: 14*_screenHeight/720)),
                  TextSpan(
                    text: ' và đang mua vé cho người có độ tuổi phù hợp',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: AppColor.white,fontSize: 14*_screenHeight/720),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * (17 / 667),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: AVButtonFill(
            height:AppSize.getHeight(context, 48) ,
            width: AppSize.getWidth(context, 312),
            onPressed: () {
              String listChairValueF1 = '';
              String seatsF1 = '';
              for (final Seat seat in widget.seats) {
                listChairValueF1 += seat.code + ',';
                seatsF1 += seat.seat + ',';
              }
              bloc.add(CheckOutEventClickButton(
                  customerFirstName: firstNameController.text,
                  customerId: 1,
                  customerLastName: lastNameController.text,
                  listChairValueF1: listChairValueF1.substring(
                      0, listChairValueF1.length - 1),
                  seatsF1: seatsF1.substring(0, seatsF1.length - 1),
                  planScreenId: widget.session.id,
                  paymentMethodSystemName: 'VNPAY'));
            },
            title: 'Tiến hành thanh toán',

          ),
        ),
      ],
    );
  }

  Widget bottomQR(BuildContext context, Widget qrCode) {
    bloc.add(CheckOutEventCheckPaymentStatus(orderId));

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Center(
            child: Text(
          'Vui lòng quét mã QR để tiến hành thanh toán',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: AppColor.white,fontSize: AppSize.getFontSize(context, 14)),
        )),
        Container(height: AppSize.getHeight(context, 8)),
        Center(
          child: Countdown(
            controller: _animationController,
            bloc: bloc,
            animation: StepTween(
              begin: levelClock, // THIS IS A USER ENTERED NUMBER
              end: 0,
            ).animate(_animationController),
          ),
        ),
        Container(height: AppSize.getHeight(context, 8),),
        qrCode,
      ],
    );
  }

  void _timeOut() {
    // flutter defined function
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          backgroundColor: AppColor.white,
          contentTextStyle: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: AppColor.black,fontSize: AppSize.getFontSize(context, 14)),
//          titlePadding: EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Thời gian phiên đặt vé của bạn đã hết'),
              Text('Vui lòng chọn lại ghế')
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Đồng ý',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppColor.blueLight, fontWeight: FontWeight.normal,fontSize: AppSize.getFontSize(context, 14)),
              ),
              onPressed: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(RoutesName.detailPage));
              },
            ),
          ],
        );
      },
    );
  }
}
String convertSeatToString(List<Seat> seatList){
  String result = '';
  for (final Seat seat in seatList){
    result+=seat.code+',';
  }
  result = result.substring(0,result.length-1);
  print(result);

  return result;
}

int sumOfPrice(List<Seat> seatList){
  int sum = 0;
  for (final Seat seat in seatList){
    sum=sum + seat.price.toInt();
  }
  return sum;
}

class Countdown extends AnimatedWidget {
  const Countdown({Key key, this.animation, this.bloc, this.controller})
      : super(key: key, listenable: animation);
  final Animation<int> animation;
  final AnimationController controller;
  final CheckOutBloc bloc;

  @override
  Widget build(BuildContext context) {
    final Duration clockTimer = Duration(seconds: animation.value);
    final String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    if (animation.value > 0) {
      return Text('(Thời thạn thanh toán: $timerText s)',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: AppColor.red,fontSize: AppSize.getFontSize(context, 14)));
    } else {
      bloc.add(CheckOutEventShowTimeOut());
      controller.reset();
      return Container();
    }
  }
}
