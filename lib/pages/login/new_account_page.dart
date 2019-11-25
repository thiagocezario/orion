import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/student_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/custom_text_form_field.dart';
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

  final RegExp _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  void _createAccount(BuildContext context, User user) {
    StudentResource.createObject(user).then((response) {
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
    final _emailField = CustomTextFormField(
      _emailFieldController,
      "Email",
      (String value) {
        if (value.isEmpty) {
          return "O campo de email deve ser preenchido";
        }

        if (!_emailRegex.hasMatch(value)) {
          return "Por favor insira um endereço de email válido";
        }

        return null;
      },
      (String value) {
        _user.email = value;
      },
      false,
    );

    final _passwordField = CustomTextFormField(
      _passwordFieldController,
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
      (String value) {
        _user.password = value;
      },
      true,
    );

    final _nameField = CustomTextFormField(
      _nameTextFieldController,
      "Nome",
      (String value) {
        if (value.isEmpty) {
          return "O campo de nome deve ser preenchido";
        }

        return null;
      },
      (String value) {
        _user.name = value;
      },
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
                  _createAccount(context, _user);
                }
              }),
            ],
          ),
        ));
  }
}
