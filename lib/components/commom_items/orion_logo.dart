import 'package:flutter/material.dart';

class OrionLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100, bottom: 50),
      child: SizedBox(
        height: 130,
        child: Image.asset(
          'assets/logo/logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
