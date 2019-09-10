import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/pages/group/new_group_page.dart';
import 'package:orion/pages/home/home_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

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
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 36.0, right: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getLogo(),
              getMessage('Login', 'Seja bem vindo'),
              SizedBox(
                height: 35.0,
              ),
              getTextField('Email', _emailFieldController),
              SizedBox(height: 10.0),
              getPasswordField('Senha', _passwordFieldController),
              SizedBox(
                height: 25.0,
              ),
              getMaterialButton(context, _formKey, 'Entrar', () {
                GroupCards.loadGroupCards();
                NewGroupPage.loadCourses();
                NewGroupPage.loadDisciplines();
                NewGroupPage.loadInstitutions();
                runApp(HomePage());
              }),
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
