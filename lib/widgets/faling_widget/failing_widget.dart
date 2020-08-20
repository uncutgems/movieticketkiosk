import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';

class FailingWidget extends StatelessWidget {
  const FailingWidget({Key key, @required this.errorMessage,  this.onPressed}) : super(key: key);

  final String errorMessage;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.getHeight(context, 330),
      width: AppSize.getWidth(context, 360),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              errorMessage,
              style: textTheme.headline6,
            ),
            Container(
              height: 8,
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: AppSize.getHeight(context, 36),
              ),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
