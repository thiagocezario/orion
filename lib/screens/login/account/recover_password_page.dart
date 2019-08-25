import 'package:flutter/material.dart';
import '../login_page.dart';

class RecoverPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 230.0,
        child: Material(
          color: Colors.transparent,
          child: Center(child: EmailForm()),
        ));
  }
}

class EmailForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // asset
        getLogo(),
        SizedBox(height: 20.0),
        getRaisedButton()
      ],
    );
  }
}

RaisedButton getRaisedButton() {
  return RaisedButton(
      color: Colors.white54,
      elevation: 10.0,
      child: Text('Logar'),
      onPressed: () => runApp(LoginPage()));
}