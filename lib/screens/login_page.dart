import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Material(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Orion',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
        ),
      )
    );
  }
}
