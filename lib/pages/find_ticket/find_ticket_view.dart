import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/style.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindTicketBloc, FindTicketState>(
      cubit: bloc,
      builder: (BuildContext context, FindTicketState state) {
        if (state is FindTicketInitial) {
          return _body(context);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _body(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _codeController = TextEditingController();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tra cứu đặt vé',
          style: textTheme.bodyText1
              .copyWith(color: AppColor.dark20, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Vui lòng nhập mã vé để tra cứu thông tin',
                  style: textTheme.bodyText2,
                ),
                Container(
                  height: screenHeight / 667 * 24,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          style: textTheme.headline5.copyWith(
                              color: AppColor.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          controller: _codeController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none),
                        ),
                        height: screenHeight / 667 * 48,
                        width: screenWidth / 360 * 312,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.white,
                        ),
                      ),
                      Container(
                        height: screenHeight / 667 * 16,
                      ),
                      Container(
                        height: screenHeight / 667 * 48,
                        width: screenWidth / 360 * 312,
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
          Center(
            child: TicketWidget(
              version: '2D',
              ticket: Ticket(ticketNo: '123435'),
              seat: 'G5',
              projectTime: '2h00',
              name: 'Van Dam',
              languageCode: 'PDV',
              cinemaId: 'Phong 2',
              projectDate: '20/12/2020',
              filmName: 'Robin Hood',
            ),
          ),
        ],
      ),
    );
  }
}
