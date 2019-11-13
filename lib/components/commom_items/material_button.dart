import 'package:flutter/material.dart';

import 'commom_items.dart';

class CustomMaterialButton extends StatelessWidget {
  final String buttonText;
  final Function function;

  CustomMaterialButton(this.buttonText, this.function);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff192376),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        elevation: 50.0,
        onPressed: () => function(),
        child: Text(buttonText,
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
