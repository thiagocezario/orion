import 'package:flutter/material.dart';
import 'package:orion/components/login/login_components.dart';
import 'package:orion/pages/home/home_page.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super (key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8893f2),
      body: getLoginForm(context, _formKey));
  }
}

/*
class LoginPage extends StatelessWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      // color: Color(0xff606fe1),
      color: Color(0xff192376),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        elevation: 50.0,
        onPressed: () {
          runApp(HomePage());
        },
        child: Text("Entrar",
            textAlign: TextAlign.center,
            style: getTextStyle().copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xff8893f2),
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
                  getTexts(),
                  SizedBox(height: 35.0,),
                  getTextField('Email'),
                  SizedBox(height: 10.0),
                  getPasswordField('Senha'),
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
                      SizedBox(width: 20.0),
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
*/
