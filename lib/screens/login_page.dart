import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Material(
          color: Colors.blue,
          child: Center(
            child: LoginForm()
          ),
        ));
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
              'Orion',
              style: TextStyle(color: Colors.white, fontSize: 50.0),
            ),
        TextFormField(),
        TextFormField(),
        ButtonBar()
      ],
    );
  }
}
