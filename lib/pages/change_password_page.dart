import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/custom_text_form_field.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/model/global.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  void _resetPassword() {
    // Navigator.of(context).pop(_passwordController.text);
    // PasswordResource.reset(Singleton().jwtToken, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final _passwordField = CustomTextFormField(
      _passwordController,
      "Nova Senha",
      (String value) {
        if (value.isEmpty) {
          return "O campo de senha deve ser preenchido";
        }

        if (value.length < 6) {
          return "O campo de senha deve ter pelo menos 6 caracteres";
        }

        return null;
      },
      () {},
      true,
    );

    final _confirmPasswordField = CustomTextFormField(
      _passwordConfirmationController,
      "Confirmar Nova Senha",
      (String value) {
        if (value.isEmpty) {
          return "O campo de senha deve ser preenchido";
        }

        if (value.length < 6) {
          return "O campo de senha deve ter pelo menos 6 caracteres";
        }

        if (value != _passwordController.text) {
          return "As senhas devem ser iguais";
        }

        return null;
      },
      () {},
      true,
    );

    final _resetPasswordButton = CustomMaterialButton(
      "Redefinir senha",
      () {
        if (_formKey.currentState.validate()) {
          _resetPassword();
        }
      },
    );

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: themeColor,
        elevation: 0.0,
        title: Text(
          'Redefinir senha',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _passwordField,
              SizedBox(height: 10.0),
              _confirmPasswordField,
              SizedBox(
                height: 25.0,
              ),
              _resetPasswordButton,
            ],
          ),
        ),
      ),
    );
  }
}
