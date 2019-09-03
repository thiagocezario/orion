import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'login_components.dart';

Form getRecoverPasswordEmailForm(BuildContext context) {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        getTextField('Email', _formKey),
        SizedBox(
          height: 25.0,
        ),
        getMaterialButton(context, _formKey, 'Redefinir Senha', () {
          Scaffold.of(context).showSnackBar(emailSentConfirmation());
        }),
      ],
    ),)
  );
}

SnackBar emailSentConfirmation() {
  return SnackBar(
    content: Text("Email para redefinição de senha enviado"),
    duration: Duration(
      seconds: 5
    ),
  );
}