import 'package:flutter/material.dart';
import 'package:orion/screens/home_page.dart';
import 'package:orion/screens/new_account.dart';
import 'package:orion/screens/recover_password.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 230.0,
        child: Material(
          color: Colors.transparent,
          child: Center(child: LoginForm()),
        ));
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // asset
        Text(
          'Orion',
          style: TextStyle(
            color: Colors.teal, 
            fontSize: 50.0
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Usuário'
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Senha',
            border: OutlineInputBorder()
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
        ),
        RaisedButton(
          color: Colors.white54,
          elevation: 10.0,
          child: Text('Logar'),
          onPressed: () => runApp(HomePage())
        ),
        ForgotPasswordSection()
      ],
    );
  }
}

class ForgotPasswordSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton(
          child: Text(
            'Criar conta',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.lightBlueAccent
            ),
          ),
          onPressed: () => runApp(NewAccount()),
        ),
        FlatButton(
          child: Text(
            'Esqueceu a senha?',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.lightBlueAccent
            ),
          ),
          onPressed: () => runApp(RecoverPasswordPage()),
        )
      ],
    );
  }
}
