import 'package:flutter/material.dart';
import 'package:orion/components/login/recover_password_components.dart';

class RecoverPasswordPage extends StatefulWidget {
  RecoverPasswordPage({Key key}) : super(key: key);

  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orion',
        home: Scaffold(
          backgroundColor: Color(0xff8893f2),
            appBar: AppBar(
              backgroundColor: Color(0xff8893f2),
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ListView(
              children: <Widget>[
                getRecoverPasswordEmailForm(context, _formKey)
              ],
            )));
  }
}
