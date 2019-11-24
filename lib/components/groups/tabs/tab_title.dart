import 'package:flutter/material.dart';
import 'package:orion/model/global.dart';

class TabTitle extends StatelessWidget {
  final String title;

  const TabTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
      child: Text(
        title,
        style: intrayTitleStyle.apply(color: themeColor),
      ),
    );
  }
}