import 'package:flutter/material.dart';

class EmptyWarning extends StatelessWidget {
  final String messsage;

  const EmptyWarning({Key key, this.messsage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        messsage,
        style: TextStyle(
          fontFamily: 'Avenir',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
