import 'package:flutter/material.dart';
import 'package:orion/actions/store_user.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/custom_text_form_field.dart';
import 'package:orion/components/origin_consumer.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/home_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:orion/provider/auth_provider.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/origin_provider.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  User _user = User();
  bool opend = false;

  _LoginPageState() {
    opend = false;
  }

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
    Provider.of<OriginProvider>(context).init();

    final userField = CustomTextFormField(
      _emailFieldController,
      "Email",
      (String value) {
        if (value.isEmpty) {
          return "O campo de email deve ser preenchido";
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

    return OriginConsumer(
      child: Scaffold(
        backgroundColor: themeColor,
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(
                'assets/logo/logo.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
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
            ),
          ],
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
