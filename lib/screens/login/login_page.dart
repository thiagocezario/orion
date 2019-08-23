import 'package:flutter/material.dart';
import 'package:orion/form/login_form.dart';

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