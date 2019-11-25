import 'package:flutter/material.dart';
import 'package:orion/actions/store_user.dart';
import 'package:orion/components/commom_items/custom_text_form_field.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/home_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:orion/provider/auth_provider.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailFieldController;
  final TextEditingController _passwordFieldController;

  LoginForm(
      this._formKey, this._emailFieldController, this._passwordFieldController);
  @override
  _LoginFormState createState() => _LoginFormState(
      _formKey, _emailFieldController, _passwordFieldController);
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailFieldController;
  final TextEditingController _passwordFieldController;
  User _user = User();

  final RegExp _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  _LoginFormState(
    this._formKey,
    this._emailFieldController,
    this._passwordFieldController,
  );

  void loadHomePage(BuildContext context) {
    Provider.of<MyGroupsProvider>(context).refreshMyGroups();
    Provider.of<GroupRecomendationsProvider>(context).refreshMyRecomendations();
    Provider.of<MyEventsProvider>(context).fetchEvents();
    Provider.of<SearchGroupsProvider>(context).refreshInstitutions();
  }

  void _signIn(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    auth.signIn(_user).then((response) {
      String token = Singleton().jwtToken;
      User user = Singleton().user;

      if (token != null && token != '') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));

        loadHomePage(context);
        storeUser(user, token);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Credenciais inválidas.'),
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
    final userField = CustomTextFormField(
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

    final passwordField = CustomTextFormField(
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

    final loginButton = CustomMaterialButton(
      'Entrar',
      () {
        if (_formKey.currentState.validate()) {
          _signIn(context);
        }
      },
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 5.0,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                ),
                userField,
                SizedBox(height: 10.0),
                passwordField,
                Container(
                  alignment: Alignment.bottomRight,
                  child: forgotPasswordButton(context),
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Novo usuário?'),
                    newAccountButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlatButton newAccountButton(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.lightBlue);

    FlatButton flatButton = FlatButton(
        child: Text('Criar nova conta', style: textStyle),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewAccountPage()),
          );
        });

    return flatButton;
  }

  FlatButton forgotPasswordButton(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.lightBlue);

    FlatButton flatButton = FlatButton(
        child: Text('Esqueceu a senha?', style: textStyle),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecoverPasswordPage()),
          );
        });

    return flatButton;
  }
}
