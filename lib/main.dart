import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/route.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/model/entity.dart';
import 'package:ncckios/pages/check_out_page/check_out_page.dart';
import 'package:ncckios/pages/default/default_page.dart';
import 'package:ncckios/pages/detail/detail_view.dart';
import 'package:ncckios/pages/film_schedule/film_schedule_page.dart';
import 'package:ncckios/pages/find_ticket/find_ticket_view.dart';
import 'package:ncckios/pages/select_seat/select_seat_screen.dart';
import 'package:ncckios/pages/home/home_view.dart';
import 'package:ncckios/pages/splash/splash_page.dart';
import 'package:ncckios/pages/successful_checkout/successful_checkout_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesName.splashPage,
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
  final Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
  switch (settings.name) {
    case RoutesName.splashPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SplashPage(),
        settings: const RouteSettings(name: RoutesName.splashPage),
      );
    case RoutesName.filmSchedulePage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => FilmSchedulePage(
          film: data[Constant.film] as Film,
        ),
        settings: const RouteSettings(name: RoutesName.filmSchedulePage),
      );
    case RoutesName.checkOutPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CheckOutPage(
          film: data[Constant.film] as Film,
          session: data[Constant.session] as Session,
          seats: data[Constant.chosenList] as List<Seat>,
        ),
        settings: const RouteSettings(name: RoutesName.checkOutPage),
      );
    case RoutesName.selectSeatPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SelectSeatPage(
          film: data[Constant.film] as Film,
          session: data[Constant.session] as Session,
        ),
        settings: const RouteSettings(name: RoutesName.selectSeatPage),
      );

    case RoutesName.homePage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomePage(),
        settings: const RouteSettings(name: RoutesName.homePage),
      );
    case RoutesName.detailPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => DetailPage(
          id: data[Constant.filmId] as int,
        ),
        settings: const RouteSettings(name: RoutesName.detailPage),
      );
    case RoutesName.findTicketPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => FindTicketPage(),
          settings: const RouteSettings(name: RoutesName.findTicketPage));
    case RoutesName.successfulCheckout:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SuccessfulCheckoutPage(
          session: data[Constant.session] as Session,
          film: data[Constant.film] as Film,
          seats: data[Constant.chosenList] as List<Seat>,
          customerLastName: data[Constant.customerLastName] as String,
          customerFirstName: data[Constant.customerFirstName] as String,
        ),
        settings: const RouteSettings(name: RoutesName.successfulCheckout),
      );

    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const DefaultPage(),
        settings: const RouteSettings(name: RoutesName.defaultPage),
      );
  }
}
