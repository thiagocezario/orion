import 'package:flutter/material.dart';

class OrionLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Image.asset(
        'assets/logo/logo.png',
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
