
import 'package:flutter/material.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';

FlatButton newAccountButton(BuildContext context) {
  TextStyle textStyle =
      TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent);

  FlatButton flatButton = FlatButton(
      child: Text('Criar nova conta', style: textStyle),
      onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewAccountPage()),
            )
          });

  return flatButton;
}

FlatButton forgotPasswordButton(BuildContext context) {
  TextStyle textStyle =
      TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent);

  FlatButton flatButton = FlatButton(
      child: Text('Esqueceu a senha?', style: textStyle),
      onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecoverPasswordPage()),
            )
          });

  return flatButton;
}

Widget getLogo() {
  return SizedBox(
    height: 150.0,
    child: Image.asset(
      'assets/logo/orionlogo.png',
      fit: BoxFit.contain,
    ),
  );
}

TextStyle getTextStyle() {
  return TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}

TextFormField getEmailField() {
  return TextFormField(
      style: getTextStyle(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
} 

TextFormField getPasswordField(String placeholder) {
  return TextFormField(
      obscureText: true,
      style: getTextStyle(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: placeholder,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
}