import 'package:flutter/material.dart';

import 'form_items/form_items.dart';
import 'login_components.dart';

Form getNewAccountForm(BuildContext context, GlobalKey<FormState> _formKey) {
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: getTextField('Email'),
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: getPasswordField('Senha')
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: getPasswordField('Confirmar senha')
        ),
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