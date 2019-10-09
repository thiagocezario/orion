import 'package:flutter/material.dart';

final textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
final errorStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 13.0);
final primaryColor = Color(0x728aff);
final primaryButtonColor = Color(0xff192376);

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

Widget getMaterialButton(BuildContext context, GlobalKey<FormState> _formKey,
    String label, Function action) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    // color: Color(0xff606fe1),
    color: Color(0xff192376),
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      elevation: 50.0,
      onPressed: () {
        // if (_formKey.currentState.validate()) {
          action();
        // }
      },
      child: Text(label,
          textAlign: TextAlign.center,
          style: textStyle
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
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
