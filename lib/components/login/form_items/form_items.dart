

import 'package:flutter/material.dart';

TextStyle getTextStyle() {
  return TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}

TextFormField getTextField(String placeholder) {
  return TextFormField(
    style: getTextStyle(),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: placeholder,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
}

TextFormField getPasswordField(String placeholder) {
  return TextFormField(
    obscureText: true,
    style: getTextStyle(),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
}

Widget getMessage(String title, String message) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          message,
          style: TextStyle(fontSize: 17.0, color: Colors.white),
        )
      ],
    ),
  );
}

Widget getMaterialButton(BuildContext context, GlobalKey<FormState> _formKey, String label) {
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
        if(_formKey.currentState.validate()) {
        }
      },
      child: Text(label,
          textAlign: TextAlign.center,
          style: getTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}
