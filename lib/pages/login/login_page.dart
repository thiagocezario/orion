import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/orion_logo.dart';
import 'package:orion/components/login/login_card.dart';
import 'package:orion/components/origin_consumer.dart';
import 'package:orion/model/global.dart';
import 'package:orion/provider/origin_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool opend = false;

  _LoginPageState() {
    opend = false;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OriginProvider>(context).init();

    return OriginConsumer(
      child: Scaffold(
        backgroundColor: themeColor,
        body: ListView(
          children: <Widget>[
            OrionLogo(),
            LoginForm(
              _formKey,
              _emailFieldController,
              _passwordFieldController,
            ),
          ],
        ),
      ),
    );
  }
}
