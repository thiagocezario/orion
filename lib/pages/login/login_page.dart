import 'package:flutter/material.dart';
import 'package:orion/components/login/login_components.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8893f2),
      body: ListView(
        children: <Widget>[
          getLoginForm(context, _formKey, _controller)
        ],
      ),
    );
  }
}
