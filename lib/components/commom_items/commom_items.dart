import 'package:flutter/material.dart';

final TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
final TextStyle appBarTextStyle =
    TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
final TextStyle errorStyle =
    TextStyle(fontFamily: 'Montserrat', fontSize: 13.0);
// final primaryColor = Color(0x728aff);
final Color primaryColor = Color(0xff8893f2);
final Color primaryButtonColor = Color(0xff192376);
final Color groupIconsColor = Color(0xFFFF8A65); // orange 300

TextFormField getTextField(
    String placeholder, TextEditingController controller) {
  return TextFormField(
    validator: (value) {
      if (value.isEmpty) {
        return "O campo de $placeholder deve ser preenchido";
      }

      return null;
    },
    controller: controller,
    style: textStyle,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: placeholder,
        errorStyle: errorStyle,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
}

Widget getLogo() {
  return SizedBox(
    height: 100.0,
    child: Image.asset(
      'assets/logo/orionlogo.png',
      fit: BoxFit.contain,
    ),
  );
}
