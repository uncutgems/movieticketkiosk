import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/widgets/shortcut/shortcut.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  Session session = Session(
    projectTime: '2020-08-11T23:00:00',
  );
  Seat seat = Seat();
  Film film = Film(
      filmName: 'Mãi bên em (2D) - C16',
      imageUrl: 'https://chieuphimquocgia.com.vn/Content/Images/0014807_0.jpeg',
      ageAboveShow: '0',
      versionCode: '2D',
      languageCode: 'PDV');
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Thanh Toán',
          style: Theme.of(context).textTheme.headline6.copyWith(
              color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  film.imageUrl,
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
          Container(
            height: 1,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: <double>[
                  0,
                  0.52,
                  1
                ],
                    colors: [
                  Color.fromARGB(32, 36, 68, 0),
                  Color(0xff5D65AA),
                  Color.fromARGB(32, 36, 68, 0),
                ])),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.036,
          ),
          Center(
            child: Text(
              'Vui lòng nhập thông tin đặt vé',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: AppColor.white),
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
          Container(
            height: 1,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: <double>[
                  0,
                  0.52,
                  1
                ],
                    colors: [
                  Color.fromARGB(32, 36, 68, 0),
                  Color(0xff5D65AA),
                  Color.fromARGB(32, 36, 68, 0),
                ])),
          ),
          Container(
            height: MediaQuery.of(context).size.height * (24 / 667),
          ),

          
          Expanded(
            child: InkWell(
              onTap: () => launch(
                  'https://chieuphimquocgia.com.vn/t/chinhsachmuave'),
              child: RichText(
                text:  TextSpan(
                  text: 'Tôi đồng ý với ',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColor.white),
                  children: <TextSpan>[
                    TextSpan(text: 'điều khoản sử dụng', style: Theme.of(context).textTheme.bodyText2.copyWith(color:AppColor.red)),
                    TextSpan(text: ' và đang mua vé cho người có độ tuổi phù hợp',style: Theme.of(context).textTheme.bodyText2.copyWith(color:AppColor.white),),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget filmInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            film.filmName,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: AppColor.white, fontSize: 16),
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
                  film.versionCode,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14, color: AppColor.red),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, top: 24.0, bottom: 16),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColor.red)),
                child: Text(
                  film.languageCode,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14, color: AppColor.red),
                ),
              ),
            ],
          ),
          Text(
            '•  ${convertTimeToDisplay(session.projectTime)}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 16,
                  color: AppColor.white,
                ),
          )
        ],
      ),
    );
  }
}
