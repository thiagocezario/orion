import 'package:flutter/material.dart';
import 'package:orion/screens/home_page.dart';
import 'package:orion/screens/new_account_page.dart';
import 'package:orion/screens/recover_password_page.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // asset
        getLogo(),
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
        ),
        getTextFormField('Usuário'),
        Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        ),
        getTextFormField('Senha'),
        Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
        ),
        getLoginButton(),
        getFlatButtonsSection()
      ],
    );
  }
}

Widget getFlatButtonsSection() {
  return Row(
    children: <Widget>[
      getFlatButton('Criar conta', NewAccountPage()),
      getFlatButton('Esqueceu a senha?', RecoverPasswordPage())
    ],
  );
}

FlatButton getFlatButton(String text, Widget page) {
  TextStyle textStyle =
      TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent);

  FlatButton flatButton = FlatButton(
    child: Text(text, style: textStyle),
    onPressed: () => runApp(page),
  );

  return flatButton;
}

RaisedButton getLoginButton() {
  return RaisedButton(
      color: Colors.white54,
      elevation: 10.0,
      child: Text('Logar'),
      onPressed: () => runApp(HomePage()));
}

TextFormField getTextFormField(String text) {
  return TextFormField(
    decoration: InputDecoration(labelText: text, border: OutlineInputBorder()),
  );
}

Widget getLogo() {
  return Text(
    'Orion',
    style: TextStyle(color: Colors.teal, fontSize: 50.0),
  );
}