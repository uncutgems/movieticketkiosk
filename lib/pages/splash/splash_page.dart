import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/route.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _navigate(context);
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: MediaQuery.of(context).size.width / 3 * 2,
          fit: BoxFit.fitWidth,
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: AppColor.primaryDarkColor,
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Text(
                'Developed by AN VUI',
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _navigate (BuildContext context) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, RoutesName.homePage);

  }
}
