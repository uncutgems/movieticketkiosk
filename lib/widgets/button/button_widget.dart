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
    this.width, this.fontsize,

  }) : super(key: key);
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double radius;
  final double height;
  final double width;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width,
      child: RaisedButton(
        color: backgroundColor ?? Theme.of(context).buttonColor,
        disabledColor: Theme.of(context).disabledColor,
        child: Text(
          title.toUpperCase() ?? '',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: textColor ?? AppColor.white,
                fontWeight: FontWeight.bold, fontSize: fontsize
              ),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12)),
      ),
    );
  }
}
