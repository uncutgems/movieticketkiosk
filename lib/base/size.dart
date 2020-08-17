import 'package:flutter/material.dart';

class AppSize {
  // Size màn hình trong thiết kế.
  static const double _baseWidth = 360;
  static const double _baseHeight = 667;

  static double getWidth(BuildContext context, double size) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return size * _screenWidth / _baseWidth;
  }

  static double getHeight(BuildContext context, double size) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return size * _screenHeight / _baseHeight;
  }

  static double getFontSize(BuildContext context, double fontSize) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return fontSize * _screenWidth / _baseWidth;
  }
}
