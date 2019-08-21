import 'package:flutter/material.dart';
import 'package:orion/screens/login_page.dart';

void main() => runApp(Orion());

class Orion extends StatelessWidget {
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
            image: getBackgroundImage()
        ),
        child: Center(
          child: LoginPage()
        )
    );
  }
}

DecorationImage getBackgroundImage() {
  AssetImage background = AssetImage('assets/background/orion.jpg');
  
  return DecorationImage(
                image: background,
                fit: BoxFit.cover);
}