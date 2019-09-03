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

Container getTextField(String placeholder) {
  TextEditingController textController = TextEditingController();

  return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: TextFormField(
        controller: textController,
        style: getTextStyle(),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: placeholder,
            fillColor: Colors.white,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      ));
}

Container getPasswordField(String placeholder) {
  TextEditingController passwordController = TextEditingController();

  return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        style: getTextStyle(),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: placeholder,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      ));
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
        if (_formKey.currentState.validate()) {
          action();
        }
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