import 'package:flutter/material.dart';
import 'package:orion/api/resources/password_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/custom_text_form_field.dart';
import 'package:orion/components/commom_items/orion_logo.dart';
import 'package:orion/components/origin_consumer.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/model/global.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final RegExp _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return OriginConsumer(
      child: Scaffold(
        backgroundColor: themeColor,
        appBar: AppBar(
          backgroundColor: themeColor,
          elevation: 0.0,
          title: Text(
            'Recuperar Senha',
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
        body: ListView(children: <Widget>[_buildForm(context)]),
      ),
    );
  }

  Builder _buildForm(context) {
    return Builder(
      builder: (context) => _buildRecoverEmailForm(context),
    );
  }

  Form _buildRecoverEmailForm(BuildContext context) {
    final _emailField = CustomTextFormField(
      _controller,
      'Email',
      (String value) {
        if (value.isEmpty) {
          return "O campo de email deve ser preenchido";
        }

        if (!_emailRegex.hasMatch(value)) {
          return "Por favor insira um endereço de email válido";
        }

        return null;
      },
      () {},
      false,
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
              SizedBox(
                height: 35.0,
              ),
              _emailField,
              SizedBox(
                height: 25.0,
              ),
              CustomMaterialButton('Redefinir senha', () {
                if (_formKey.currentState.validate()) {
                  PasswordResource.recover(_controller.text).then((response) {
                    print(response.body);
                  });
                  Scaffold.of(context).showSnackBar(emailSentConfirmation());
                }
              }),
            ],
          ),
        ));
  }

  SnackBar emailSentConfirmation() {
    return SnackBar(
      content: Text("Email para redefinição de senha enviado"),
      duration: Duration(seconds: 5),
    );
  }
}
