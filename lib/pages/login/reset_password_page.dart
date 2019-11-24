import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/commom_items/commom_items.dart';
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
  final _passworController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  String token;

  _ResetPasswordPageState({this.token});

  void _resetPasswor() {
    Navigator.of(context).pop(_passworController.text);
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
    final _passwordField = TextFormField(
      controller: _passworController,
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de senha deve ser preenchido";
        }

        return null;
      },
      obscureText: true,
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Senha',
          errorStyle: errorStyle,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );

    final _confirmPasswordField = TextFormField(
      controller: _passwordConfirmationController,
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de nome deve ser preenchido";
        }

        return null;
      },
      obscureText: true,
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Confirmação da senha',
          errorStyle: errorStyle,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );

    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getLogo(),
              SizedBox(
                height: 35.0,
              ),
              _passwordField,
              SizedBox(height: 10.0),
              _confirmPasswordField,
              SizedBox(
                height: 25.0,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                // color: Color(0xff606fe1),
                color: Color(0xff192376),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  elevation: 50.0,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _resetPasswor();
                    }
                  },
                  child: Text('Redefinir senha',
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ));
  }
}
