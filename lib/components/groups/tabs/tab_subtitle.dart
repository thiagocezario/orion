import 'package:flutter/material.dart';
import 'package:orion/model/global.dart';

class TabSubtitle extends StatelessWidget {
  final String title;
  final Function onAddPressed;

  const TabSubtitle({Key key, this.title, this.onAddPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            title,
            style: intraySubTitleStyle,
          ),
        ),
        Container(
          child: MaterialButton(
            elevation: 1,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  'Registrar',
                  style: addButtonStyle,
                )
              ],
            ),
            color: themeColor,
            onPressed: onAddPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        )
      ],
    );
  }
}
