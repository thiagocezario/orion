import 'package:flutter/material.dart';

final TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
final TextStyle appBarTextStyle =
    TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
final TextStyle errorStyle =
    TextStyle(fontFamily: 'Montserrat', fontSize: 13.0);
final Color primaryButtonColor = Color(0xff192376);
final Color groupIconsColor = Color(0xFFFF8A65); // orange 300

Widget getLogo() {
  return SizedBox(
    height: 100.0,
    child: Image.asset(
      'assets/logo/logo.png',
      fit: BoxFit.contain,
    ),
  );
}
