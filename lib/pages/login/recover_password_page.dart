import 'package:flutter/material.dart';
import 'package:orion/components/login/form_items/form_items.dart';
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
    return Scaffold(
          backgroundColor: Color(0xff8893f2),
            appBar: getAppBar(context),
            body: ListView(
              children: <Widget>[
                _buildForm(context)
              ],
            ));
  }

  Widget _buildForm(context) {
    return Builder(
      builder: (context) => getRecoverPasswordEmailForm(context, _formKey),
    );
  }
}