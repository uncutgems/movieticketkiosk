import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';

class AVButtonFill extends StatelessWidget {
  const AVButtonFill({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.radius,
    this.height,
  }) : super(key: key);
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double radius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      child: RaisedButton(
        color: backgroundColor ?? Theme.of(context).buttonColor,
        disabledColor: Theme.of(context).disabledColor,
        child: Text(
          title.toUpperCase() ?? '',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: textColor ?? AppColor.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12)),
      ),
    );
  }
}
