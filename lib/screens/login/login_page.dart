import 'package:flutter/material.dart';
import 'package:orion/screens/home/home_page.dart';
import 'package:orion/screens/login/account/new_account_page.dart';
import 'package:orion/screens/login/account/recover_password_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Senha",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          runApp(HomePage());
        },
        child: Text("Entrar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: ListView(
      children: <Widget>[
        Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getLogo(),
                  emailField,
                  SizedBox(height: 5.0),
                  passwordField,
                  SizedBox(
                    height: 25.0,
                  ),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      newAccountButton(context),
                      forgotPasswordButton(context)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

FlatButton newAccountButton(BuildContext context) {
  TextStyle textStyle =
      TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent);

  FlatButton flatButton = FlatButton(
      child: Text('Criar nova conta', style: textStyle),
      onPressed: () => {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => NewAccountPage()),
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
