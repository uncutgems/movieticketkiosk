import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';

import '../../base/route.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _navigateToHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: AppSize.getWidth(context, 200),
          fit: BoxFit.fitWidth,
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: AppColor.primaryDarkColor,
            padding: EdgeInsets.all(AppSize.getWidth(context, 4)),
            child: Center(
              child: Text(
                'Developed by AN VUI',
                style: textTheme.bodyText2.copyWith(color: AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToHome(BuildContext context) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, RoutesName.homePage);
  }
}
