import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/student_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/user.dart';

class NewAccountPage extends StatefulWidget {
  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _nameTextFieldController = TextEditingController();
  final _user = User();

  void _createAccount(BuildContext context) {
    StudentResource.createObject(_user).then((response) {
      if (response != null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Conta criada com sucesso!'),
          ),
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Não foi possível criar a conta. Por favor, tente novamente mais tarde.'),
          ),
        );
      }
    }).catchError((e) {
      print(e);
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
        backgroundColor: themeColor,
        appBar: AppBar(
          backgroundColor: themeColor,
          elevation: 0.0,
          title: Text(
            'Nova Conta',
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
    final _emailField = TextFormField(
      controller: _emailFieldController,
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de email deve ser preenchido";
        }

        return null;
      },
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email',
          errorStyle: errorStyle,
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
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Senha',
          errorStyle: errorStyle,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      onChanged: (text) => _user.password = text,
    );

    final _nameField = TextFormField(
      controller: _nameTextFieldController,
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de nome deve ser preenchido";
        }

        return null;
      },
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Nome',
          errorStyle: errorStyle,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      onChanged: (text) => _user.name = text,
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
              _nameField,
              SizedBox(height: 10.0),
              _emailField,
              SizedBox(height: 10.0),
              _passwordField,
              SizedBox(
                height: 25.0,
              ),
              CustomMaterialButton('Criar nova conta', () {
                if (_formKey.currentState.validate()) {
                  _createAccount(context);
                }
              }),
            ],
          ),
        ));
  }
}
