import 'package:flutter/material.dart';

import 'form_items/form_items.dart';
import 'login_components.dart';

Form getRecoverPasswordEmailForm(BuildContext context, GlobalKey<FormState> _formKey) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.only(left: 36.0, right: 36.0),
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
        SizedBox(
          height: 25.0,
        ),
        getMaterialButton(context, _formKey, 'Redefinir Senha'),
      ],
    ),)
  );
}