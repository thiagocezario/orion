import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'login_components.dart';

Form getNewAccountForm(BuildContext context, GlobalKey<FormState> _formKey, TextEditingController controller) {
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
        getTextField('Email', controller),
        SizedBox(height: 10.0),
        getPasswordField('Senha', controller),
        SizedBox(height: 10.0),
        getPasswordField('Confirmar senha', controller),
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