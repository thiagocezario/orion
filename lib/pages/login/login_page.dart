import 'package:flutter/material.dart';
import 'package:orion/actions/store_user.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/origin_consumer.dart';
import 'package:orion/components/commom_items/material_button.dart';
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
    // _emailFieldController.text = "user@user.com";
    // _passwordFieldController.text = "123123";
    // _user.email = "user@user.com";
    // _user.password = "123123";
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

    final userField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de email deve ser preenchido";
        }

        return null;
      },
      controller: _emailFieldController,
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email',
          errorStyle: errorStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      onChanged: (text) => _user.email = text,
    );

    final passwordField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "O campo de senha deve ser preenchido";
        }

        return null;
      },
      controller: _passwordFieldController,
      obscureText: true,
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Senha',
          errorStyle: errorStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      onChanged: (text) => _user.password = text,
    );

    return OriginConsumer(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(top: 100, bottom: 50),
                // height: 300,
                child: SizedBox(
                  height: 130.0,
                  child: Image.asset(
                    'assets/logo/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 5.0,
                  color: Colors.white,
                  child: Wrap(
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(left: 35.0, right: 35.0),
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
                                CustomMaterialButton(
                                  'Entrar',
                                  () {
                                    if (_formKey.currentState.validate()) {
                                      _signIn(context);
                                    }
                                  },
                                ),
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
                          )),
                    ],
                  ),
                ),
              ),
            ]),
          )
        ],
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
          // Navigator.pushNamed(context, '/new_account');
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
          // Navigator.pushNamed(context, '/recover_password');
        });

    return flatButton;
  }
}
