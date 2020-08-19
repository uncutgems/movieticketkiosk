import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/size.dart';

class VersionCodeContainer extends StatelessWidget {
  const VersionCodeContainer({
    Key key,
    this.context,
    @required this.versionCode,
  }) : super(key: key);

  final String versionCode;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    List<String> result = <String>[];
    if (versionCode.contains(',')) {
      result = versionCode.split(',');
    } else {
      result.add(versionCode);
    }
    final List<Widget> widget = <Widget>[];

    for (final String vCode in result) {
      widget.add(
        Container(
          padding: const EdgeInsets.all(4.0),
          height: AppSize.getHeight(context, 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  width: AppSize.getWidth(context, 1), color: AppColor.red,style: BorderStyle.solid)),
          child: Center(
            child: Text(
              vCode,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 19, color: AppColor.red),
            ),
          ),
        ),
      );
    }
    return Row(children: widget);
  }
}
