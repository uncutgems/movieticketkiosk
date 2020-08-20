import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/find_ticket/find_ticket_bloc.dart';
import 'package:ncckios/widgets/button/button_widget.dart';
import 'package:ncckios/widgets/ticket/ticket_widget.dart';

class FindTicketPage extends StatefulWidget {
  @override
  _FindTicketPageState createState() => _FindTicketPageState();
}

class _FindTicketPageState extends State<FindTicketPage> {
  final FindTicketBloc bloc = FindTicketBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    bloc.close();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindTicketBloc, FindTicketState>(
      cubit: bloc,
      builder: (BuildContext context, FindTicketState state) {
        if (state is FindTicketInitial) {
          return _body(context, Container());
        } else if (state is GetTicketSuccessFindTicketState) {
          return _body(context, _ticket(context, state));
        } else if (state is GetTicketFailFindTicketState) {
          return _body(context, _error(context, state));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _body(BuildContext context, Widget widget) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tra cứu đặt vé',
          style: textTheme.bodyText1.copyWith(
              color: AppColor.dark20, fontWeight: FontWeight.w500, fontSize: AppSize.getFontSize(context, 20)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: AppSize.getFontSize(context, 20),
          ),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName(RoutesName.homePage));
          },
        ),
        toolbarHeight: AppSize.getHeight(context, 48),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.getWidth(context, 24),
              vertical: AppSize.getHeight(context, 24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Vui lòng nhập mã vé để tra cứu thông tin',
                  style: textTheme.bodyText2.copyWith(fontSize: AppSize.getFontSize(context, 14)),
                ),
                Container(
                  height: AppSize.getHeight(context, 24),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          style: textTheme.headline5.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.getFontSize(context, 24)),
                          textAlign: TextAlign.center,
                          controller: _codeController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none),
                        ),
                        height: AppSize.getHeight(context, 40),
                        width: AppSize.getWidth(context, 312),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.white,
                        ),
                      ),
                      Container(
                        height: AppSize.getHeight(context, 16),
                      ),
                      Container(
                        height: AppSize.getHeight(context, 48),
                        width: AppSize.getWidth(context, 312),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AVButtonFill(
                          title: 'TRA CỨU THÔNG TIN VÉ',
                          onPressed: () {
                            bloc.add(CLickFindTicketEvent(_codeController.text));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget,
        ],
      ),
    );
  }

  Widget _ticket(BuildContext context, GetTicketSuccessFindTicketState state) {
    final OrderInfo order = state.orderInfo;
    if (state.orderInfo.filmName == null) {
      return Center(
        child: SizedBox(
          width: AppSize.getWidth(context, 40),
          height: AppSize.getHeight(context, 40),
          child: const CircularProgressIndicator(
            strokeWidth: 10,
            backgroundColor: AppColor.blue,
          ),
        ),
      );
    } else {
      return TicketWidget(
        orderId: _codeController.text,
        filmName: order.filmName,
        version: order.versionCode,
        seat: order.seats,
        name: order.customerName,
        languageCode: order.languageCode,
        cinemaId: order.roomName,
        projectDate: convertTime('dd/MM/yyy', DateTime.parse(order.projectDate).millisecondsSinceEpoch, false),
        projectTime: convertTime('hh:mm', DateTime.parse(order.projectTime).millisecondsSinceEpoch, false),
      );
    }
  }

  Widget _error(BuildContext context, GetTicketFailFindTicketState state) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            state.error,
            style: textTheme.headline6.copyWith(color: AppColor.white, fontSize: AppSize.getFontSize(context, 18)),
          ),
        ],
      ),
    );
  }
}
