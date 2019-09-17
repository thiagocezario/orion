import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

enum CustomColors { mainBackgroundColor, mainActionButtonColor }

_customColors(CustomColors color) {
  switch (color) {
    case CustomColors.mainBackgroundColor:
      return Color(0xff8893f2);
    case CustomColors.mainActionButtonColor:
      return Color(0xff192376);
    default:
      return Color(0xffffffff);
  }
}

TextStyle getTextStyle() {
  return TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}

TextStyle errorStyle() {
  return TextStyle(fontFamily: 'Montserrat', fontSize: 13.0, color: Colors.redAccent);
}

TextFormField getTextField(
    String placeholder, TextEditingController controller) {
  return TextFormField(
    validator: (value) {
      if (value.isEmpty) {
        return "O campo de $placeholder deve ser preenchido";
      }
    },
    controller: controller,
    style: getTextStyle(),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: placeholder,
        errorStyle: errorStyle(),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
}

TextFormField getPasswordField(
    String placeholder, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value.isEmpty) {
        return "O campo de senha deve ser preenchido";
      }
    },
    obscureText: true,
    style: getTextStyle(),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: placeholder,
        errorStyle: errorStyle(),
        fillColor: Colors.white,
        filled: true,
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
              fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          message,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

Widget getTitleMessage(String title, Color color) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 30.0, color: color, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    ),
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
          style: getTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

AppBar getAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xff8893f2),
    elevation: 0.0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () => Navigator.pop(context),
    ),
  );
}

Widget getLogo() {
  return SizedBox(
    height: 120.0,
    child: Image.asset(
      'assets/logo/orionlogo.png',
      fit: BoxFit.contain,
    ),
  );
}
