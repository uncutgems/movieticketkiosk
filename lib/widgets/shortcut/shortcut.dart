import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';

Widget nameBox(
    BuildContext context, TextEditingController controller, String text) {
  final double _screenHeight=MediaQuery.of(context).size.height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(text,style: Theme.of(context).textTheme.bodyText2.copyWith(color:AppColor.white,fontSize: 16*_screenHeight/720),),
      Container(
        height: MediaQuery.of(context).size.height*(8/667),
      ),
      Container(
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
//          color: AppColor.white,
      height:  40*_screenHeight/720,
        child: TextFormField(
          cursorColor: Colors.white,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16*_screenHeight/720),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all( 16),
            border: InputBorder.none,
          ),
          obscureText: false,
          controller: controller,
        ),
      ),
    ],
  );
}
Widget gradientLine(BuildContext context){
  return  Container(
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
            colors: <Color>[
              Color.fromARGB(32, 36, 68, 0),
              Color(0xff5D65AA),
              Color.fromARGB(32, 36, 68, 0),
            ])),
  );
}
void fail(String error,BuildContext context){
  showDialog<dynamic>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: const <Widget>[
          CloseButton()
        ],
        title: Text(error),
      );
    },
  );
}
Widget loading(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(height: MediaQuery.of(context).size.height/3,),
      const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
        ),
      ),
    ],
  );
}
