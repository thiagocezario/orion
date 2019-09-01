import 'package:flutter/material.dart';

import 'form_items/form_items.dart';
import 'login_components.dart';

Form getRecoverPasswordForm(BuildContext context, GlobalKey<FormState> _formKey) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.all(36.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        getLogo(),
        getMessage('Esqueceu a senha?', 'Só precisamos do seu email de cadastro para redefinir a senha.'),
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
        SizedBox(
          height: 25.0,
        ),
        getMaterialButton(context, _formKey, 'Redefinir Senha'),
        SizedBox(
          height: 15.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            newAccountButton(context),
            SizedBox(width: 20.0),
            forgotPasswordButton(context)
          ],
        ),
      ],
    ),)
  );
}