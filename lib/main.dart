import 'package:flutter/material.dart';
import 'package:orion/screens/login_page.dart';

void main() => runApp(FirstApp());

class FirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orion',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: LoginPage()
        )
      )
    );
  }
}