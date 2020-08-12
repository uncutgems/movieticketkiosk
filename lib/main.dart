import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/pages/check_out_page/check_out_page.dart';
import 'package:ncckios/pages/default/default_page.dart';
import 'package:ncckios/pages/film_schedule/film_schedule_page.dart';
import 'package:ncckios/pages/select_seat/select_seat_screen.dart';
import 'package:ncckios/pages/home/home_view.dart';
import 'package:ncckios/pages/splash/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesName.selectSeatPage,
      onGenerateRoute: (RouteSettings settings) => routeSettings(settings),
      debugShowCheckedModeBanner: false,
      theme: themeData,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('vi', 'VN'), // Viet Nam
      ],
    );
  }
}

MaterialPageRoute<dynamic> routeSettings(RouteSettings settings) {
  //final dynamic data = settings.arguments;
  switch (settings.name) {
    case RoutesName.splashPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SplashPage(),
        settings: const RouteSettings(name: RoutesName.splashPage),
      );
    case RoutesName.filmSchedulePage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => FilmSchedulePage(),
        settings: const RouteSettings(name: RoutesName.filmSchedulePage),
      );
    case RoutesName.checkOutPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CheckOutPage(),
        settings: const RouteSettings(name: RoutesName.checkOutPage),
      );
    case RoutesName.selectSeatPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SelectSeatPage(),
        settings: const RouteSettings(name: RoutesName.selectSeatPage),
      );

    case RoutesName.homePage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomePage(),
        settings: const RouteSettings(name: RoutesName.homePage),
      );

    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const DefaultPage(),
        settings: const RouteSettings(name: RoutesName.defaultPage),
      );
  }
}
