import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/commom_items/custom_text_form_field.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/commom_items/orion_logo.dart';
import 'package:orion/model/global.dart';

class ResetPasswordPage extends StatefulWidget {
  final String token;

  ResetPasswordPage({this.token});

  @override
  _ResetPasswordPageState createState() =>
      _ResetPasswordPageState(token: token);
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  String token;

  _ResetPasswordPageState({this.token});

  void _resetPassword() {
    Navigator.of(context).pop(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeColor,
        appBar: AppBar(
          backgroundColor: themeColor,
          elevation: 0.0,
          title: Text(
            'Redefinir senha',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Builder(
          builder: (context) {
            return ListView(
              children: <Widget>[_buildForm(context)],
            );
          },
        ));
  }

  Form _buildForm(BuildContext context) {
    final _passwordField = CustomTextFormField(
      _passwordController,
      "Senha",
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
      "Confirmar Senha",
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

    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OrionLogo(),
              _passwordField,
              SizedBox(height: 10.0),
              _confirmPasswordField,
              SizedBox(
                height: 25.0,
              ),
              _resetPasswordButton,
            ],
          ),
        ));
  }
}
