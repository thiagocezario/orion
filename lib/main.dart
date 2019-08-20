import 'package:flutter/material.dart';
import 'package:orion/screens/login_page.dart';

void main() => runApp(FirstApp());

class FirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orion',
        home: Scaffold(body: InitialCustomization()));
  }
}

class InitialCustomization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background/orion.jpg'),
                fit: BoxFit.cover)
        ),
        child: Center(
          child: LoginPage()
        )
    );
  }
}