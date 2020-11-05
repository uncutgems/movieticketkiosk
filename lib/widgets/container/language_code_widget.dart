import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/size.dart';

class LanguageCodeContainer extends StatelessWidget {
  const LanguageCodeContainer({Key key, @required this.languageCode}) : super(key: key);

  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(4.0),
      height: AppSize.getHeight(context, 24),
      decoration:
      BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all( width: AppSize.getWidth(context, 1),color: AppColor.red,style: BorderStyle.solid)),
      child: Center(
        child: Text(
          languageCode,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontSize: 19, color: AppColor.red),
        ),
      ),
    );
  }
}
