import 'package:flutter/material.dart';
import 'package:orion/screens/login/login_page.dart';

void main() => runApp(Orion());

class Orion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}

class InitialCustomization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(image: getBackgroundImage()),
        child: Center(child: LoginPage()));
  }
}

DecorationImage getBackgroundImage() {
  AssetImage background = AssetImage('assets/background/orion.jpg');

  return DecorationImage(image: background, fit: BoxFit.cover);
}
