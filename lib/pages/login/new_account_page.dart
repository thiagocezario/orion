import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/user/client.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/user.dart';

class NewAccountPage extends StatefulWidget {
  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _confirmPasswordFieldController = TextEditingController();
  final _user = User();

  void _createAccount(BuildContext context) {
    Client.createUser(_user).then((response) {
      if (response) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário criado com sucesso'),
          ),
        );
        Navigator.of(context).pop();
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Não foi possível criar a conta. Por favor, tente novamente mais tarde.'),
          ),
        );
      }
    }).catchError((e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocorreu um erro. Tente novamente em alguns minutos.'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff8893f2),
        appBar: getAppBar(context),
        body: Builder(
          builder: (context) {
            return ListView(
              children: <Widget>[_buildForm(context)],
            );
          },
        ));
  }

  Form _buildForm(BuildContext context) {
    final _emailField = TextFormField(
      controller: _emailFieldController,
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de email deve ser preenchido";
        }

        return null;
      },
      style: getTextStyle(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email',
          // errorStyle: errorStyle(),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      onChanged: (text) => _user.email = text,
    );

    final _passwordField = TextFormField(
      controller: _passwordFieldController,
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de senha deve ser preenchido";
        }

        return null;
      },
      obscureText: true,
      style: getTextStyle(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Senha',
          // errorStyle: errorStyle(),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      onChanged: (text) => _user.password = text,
    );

    final _confirmPasswordField = TextFormField(
      controller: _confirmPasswordFieldController,
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de confirme a senha deve ser preenchido";
        } else if (value != _passwordFieldController.text) {
          return "O campo de confirme a senha deve ser igual ao campo de senha";
        }

        return null;
      },
      obscureText: true,
      style: getTextStyle(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Confirme a senha',
          // errorStyle: errorStyle(),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );

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
              _emailField,
              SizedBox(height: 10.0),
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
                      _createAccount(context);
                    }
                  },
                  child: Text('Criar conta',
                      textAlign: TextAlign.center,
                      style: getTextStyle().copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ));
  }
}
