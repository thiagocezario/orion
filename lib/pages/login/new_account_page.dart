import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/commom_items/commom_items.dart';

class NewAccountPage extends StatefulWidget {
  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _confirmPasswordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff8893f2),
        appBar: getAppBar(context),
        body: ListView(
          children: <Widget>[_buildForm(context)],
        ));
  }

  Form _buildForm(BuildContext context) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.only(left: 36.0, right: 36.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        getLogo(),
        getMessage('Criar conta', 'Seja mais um membro!'),
        SizedBox(
          height: 35.0,
        ),
        getTextField('Email', _emailFieldController),
        SizedBox(height: 10.0),
        getPasswordField('Senha', _passwordFieldController),
        SizedBox(height: 10.0),
        getPasswordField('Confirmar senha', _confirmPasswordFieldController),
        SizedBox(
          height: 25.0,
        ),
        getMaterialButton(context, _formKey, 'Criar conta', () {
          // Alert with message and call back to login page
        }),
      ],
    ),)
  );
}
}
