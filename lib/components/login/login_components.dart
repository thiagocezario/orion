import 'package:flutter/material.dart';
import 'package:orion/pages/home/home_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';

Form getLoginForm(BuildContext context, GlobalKey<FormState> _formKey) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.all(36.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        getLogo(),
        getTexts(),
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
        getLoginButton(context, _formKey),
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

Widget getLoginButton(BuildContext context, GlobalKey<FormState> _formKey) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    // color: Color(0xff606fe1),
    color: Color(0xff192376),
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      elevation: 50.0,
      onPressed: () {
        if(_formKey.currentState.validate()) {
          runApp(HomePage());
        }
      },
      child: Text("Entrar",
          textAlign: TextAlign.center,
          style: getTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
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

TextFormField getTextField(String placeholder) {
  return TextFormField(
    style: getTextStyle(),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: placeholder,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
}

TextFormField getPasswordField(String placeholder) {
  return TextFormField(
    obscureText: true,
    style: getTextStyle(),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
}

Widget getTexts() {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Login',
          style: TextStyle(
              fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Seja bem vindo',
          style: TextStyle(fontSize: 17.0, color: Colors.white),
        )
      ],
    ),
  );
}
