import 'package:flutter/material.dart';
import 'package:orion/pages/home/home_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';

import 'form_items/form_items.dart';

Form getLoginForm(BuildContext context, GlobalKey<FormState> _formKey) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.only(left: 36.0, right: 36.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        getLogo(),
        getMessage('Login', 'Seja bem vindo'),
        SizedBox(
          height: 35.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: getTextField('Email'),
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: getPasswordField('Senha')
        ),
        SizedBox(
          height: 25.0,
        ),
        getMaterialButton(context, _formKey, 'Entrar', () {
          runApp(HomePage());
        }),
        SizedBox(
          height: 15.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            newAccountButton(context),
            SizedBox(width: 20.0),
            forgotPasswordButton(context)
          ],
        ),
      ],
    ),)
  );
}

FlatButton newAccountButton(BuildContext context) {
  TextStyle textStyle =
      TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent);

  FlatButton flatButton = FlatButton(
      child: Text('Criar nova conta', style: textStyle),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewAccountPage()),
        );
      });

  return flatButton;
}

FlatButton forgotPasswordButton(BuildContext context) {
  TextStyle textStyle =
      TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent);

  FlatButton flatButton = FlatButton(
      child: Text('Esqueceu a senha?', style: textStyle),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecoverPasswordPage()),
        );
      });

  return flatButton;
}

Widget getLogo() {
  return SizedBox(
    height: 120.0,
    child: Image.asset(
      'assets/logo/orionlogo.png',
      fit: BoxFit.contain,
    ),
  );
}