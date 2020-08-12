import 'package:flutter/material.dart';

import '../../base/route.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key key, this.message}) : super(key: key);
  final String message;

  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: RaisedButton(onPressed: () {
        Navigator.pushNamed(
          context,
          RoutesName.selectSeatPage,
        );
      },),
    );
  }
}
