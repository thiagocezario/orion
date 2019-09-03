import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/login/recover_password_components.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

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
      builder: (context) => getRecoverPasswordEmailForm(context, _formKey, _controller),
    );
  }
}