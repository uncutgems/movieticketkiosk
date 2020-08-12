import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/model/entity.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Film film = Film(
      filmName: 'Mãi bên em (2D) - C16',
      imageUrl: 'https://chieuphimquocgia.com.vn/Content/Images/0014807_0.jpeg',
      ageAboveShow: '0',
      versionCode: '2D',
      languageCode: 'PDV');

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
          )
        ],
      ),
    );
  }

  Widget filmInfo(BuildContext context) {
    return Column(
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
              margin: const EdgeInsets.only(left:24.0,top: 24.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
              border: Border.all(color: AppColor.red)
    ),
              child: Text(film.versionCode,style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14,color: AppColor.red),),
            ),
            Container(
              margin: const EdgeInsets.only(left:16.0,top: 24.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.red)
              ),
              child: Text(film.languageCode,style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14,color: AppColor.red),),
            ),
          ],
        ),
      ],
    );
  }
}
