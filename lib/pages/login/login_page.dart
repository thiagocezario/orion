import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/home/home_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:orion/provider/auth_provider.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
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

  void _signIn(BuildContext context) {
    Provider.of<AuthProvider>(context).signIn(_user).then((response) {
      String token = Provider.of<AuthProvider>(context).accessToken;
      if (token != null && token != '') {
        Provider.of<MyGroupsProvider>(context).refreshMyGroups();
        Provider.of<GroupRecomendationsProvider>(context).refreshMyRecomendations();
        Provider.of<MyEventsProvider>(context).fetchEvents();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
    return Scaffold(
      backgroundColor: Color(0xff8893f2),
      body: ListView(
        children: <Widget>[_buildForm(context)],
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    _emailFieldController.text = "user@user.com";
    _passwordFieldController.text = "123123";
    _user.email = "user@user.com";
    _user.password = "123123";

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
          fillColor: Colors.white,
          filled: true,
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
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      onChanged: (text) => _user.password = text,
    );

    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getLogo(),
              SizedBox(
                height: 35.0,
              ),
              userField,
              SizedBox(height: 10.0),
              passwordField,
              SizedBox(
                height: 25.0,
              ),
              Builder(
                builder: (context) => Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff192376),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    elevation: 50.0,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _signIn(context);
                      }
                    },
                    child: Text('Entrar',
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  newAccountButton(context),
                  SizedBox(width: 20.0),
                  forgotPasswordButton(context)
                ],
              ),
            ],
          ),
        ));
  }

  FlatButton newAccountButton(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.white);

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
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.white);

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
