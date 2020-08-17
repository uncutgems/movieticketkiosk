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
        centerTitle: true,
        title: Text(
          'Tra cứu đặt vé',
          style: textTheme.bodyText1
              .copyWith(color: AppColor.dark20, fontWeight: FontWeight.w500, fontSize: screenHeight/667*16),
        ),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, size: screenHeight/667*16,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight/667*24.0, vertical: screenWidth/360*24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Vui lòng nhập mã vé để tra cứu thông tin',
                  style: textTheme.bodyText2.copyWith(fontSize:  screenHeight/667*14),
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
                          fontSize: screenHeight/667*16,
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
              ticket: Ticket(ticketNo: '09744283'),
              projectDate: '20/10/2020',
              projectTime: '20h00',
              cinemaId: 'Rạp 2',
              languageCode: 'Phụ đề Việt',
              name: 'Vân Đàm',
              seat: '5G',
              version: '2D',
              filmName: 'Gone with the wind',


            ),
          ),

        ],
      ),
    );
  }
}
