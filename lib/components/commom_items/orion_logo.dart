import 'package:flutter/material.dart';

class OrionLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 70, bottom: 30,),
      child: SizedBox(
        height: MediaQuery.of(context).size.height/5,
        child: Image.asset(
          'assets/logo/logo.png',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
