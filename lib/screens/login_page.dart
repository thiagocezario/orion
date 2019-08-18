import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
            color: Colors.blue,
            child: Center(
              child: Text(
                'Orion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0
                  ),
              ),
            ),
          );
  }
}