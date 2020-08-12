import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/pages/splash/splash_bloc.dart';
import 'package:ncckios/base/route.dart';
import '../../base/route.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}



class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
            () =>  Navigator.pushNamed(
          context,
          RoutesName.defaultPage,
        ));
  }

  @override
  void initState() {
    _navigateToHome(context);
     super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      cubit: bloc,
      buildWhen: (SplashState prev, SplashState state) {
        if (state is SplashStateNextPage) {
          Navigator.pushNamed(context,'/checkOutPage');
          return false;
        } else {
          return true;
        }
      },
      builder: (BuildContext context, SplashState state) {
        if (state is SplashInitial) {
          return _splashPage(context);
        }
        return const Material();
      },
    );
  }

  Widget _splashPage(BuildContext context){
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
  Future<void> _navigateToHome (BuildContext context) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, RoutesName.homePage);

  }
}
