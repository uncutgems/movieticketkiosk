import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncckios/base/color.dart';

class AppPadding {
  static const EdgeInsets normalPadding = EdgeInsets.all(16);
}

final ThemeData themeData = ThemeData(
  primaryColor: AppColor.primaryColor,
  primaryColorBrightness: Brightness.dark,
  primaryColorDark: AppColor.primaryDarkColor,
  accentColor: AppColor.accentColor,
  accentColorBrightness: Brightness.light,
  primaryColorLight: AppColor.primaryColorLight,
  backgroundColor: AppColor.primaryColor,
  iconTheme: iconThemeData,
  appBarTheme: appBarTheme,
  buttonTheme: buttonThemeData,
  buttonColor: AppColor.buttonColor,
  disabledColor: AppColor.disableColor,
  scaffoldBackgroundColor: AppColor.primaryColor,
  dialogTheme: dialogTheme,
);

final DialogTheme dialogTheme = DialogTheme(
  backgroundColor: AppColor.primaryColor,
  titleTextStyle: textTheme.headline6,
  contentTextStyle: textTheme.bodyText1,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);
const ButtonThemeData buttonThemeData = ButtonThemeData(
  disabledColor: AppColor.disableColor,
  buttonColor: AppColor.buttonColor,
  textTheme: ButtonTextTheme.primary,
);

final AppBarTheme appBarTheme = AppBarTheme(
  iconTheme: iconThemeData,
  color: AppColor.primaryColor,
  brightness: Brightness.dark,
  actionsIconTheme: iconThemeData,
  textTheme: textTheme.copyWith(headline6: textTheme.headline6.copyWith(color: AppColor.white)),
  elevation: 0.0,
);

const IconThemeData iconThemeData = IconThemeData(
  color: AppColor.white,
);

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.roboto(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: AppColor.white,
  ),
  headline2: GoogleFonts.roboto(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: AppColor.white,
  ),
  headline3: GoogleFonts.roboto(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  ),
  headline4: GoogleFonts.roboto(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColor.white,
  ),
  headline5: GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  ),
  headline6: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColor.white,
  ),
  subtitle1: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppColor.white,
  ),
  subtitle2: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColor.white,
  ),
  bodyText1: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColor.white,
  ),
  bodyText2: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColor.white,
  ),
  button: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: AppColor.white,
  ),
  caption: GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColor.white,
  ),
  overline: GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: AppColor.white,
  ),
);

final BoxDecoration filmBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(12),

);
