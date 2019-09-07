import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';

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
          children: <Widget>[_buildForm(context)],
        ));
  }

  Builder _buildForm(context) {
    return Builder(
      builder: (context) => _buildRecoverEmailForm(context),
    );
  }

  Form _buildRecoverEmailForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 36.0, right: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getLogo(),
              getMessage('Esqueceu a senha?',
                  'Só precisamos do seu email de cadastro para redefinir a senha.'),
              SizedBox(
                height: 35.0,
              ),
              getTextField('Email', _controller),
              SizedBox(
                height: 25.0,
              ),
              getMaterialButton(context, _formKey, 'Redefinir Senha', () {
                Scaffold.of(context).showSnackBar(emailSentConfirmation());
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
