import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
        children: [
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
}
