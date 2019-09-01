import 'package:flutter/material.dart';
import 'package:orion/components/login/login_components.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8893f2),
      body: ListView(
        children: <Widget>[
          getLoginForm(context, _formKey)
        ],
      )
      );
  }
}