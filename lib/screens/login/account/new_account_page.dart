import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../main.dart';
import '../login_page.dart';

class NewAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orion',
      home: NewAccountForm(title: 'Nova conta'),
    );
  }
}

class NewAccountForm extends StatefulWidget {
  NewAccountForm({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _NewAccountFormState createState() => _NewAccountFormState();
}

class _NewAccountFormState extends State<NewAccountForm> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Senha",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final confirmPasswordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirmar Senha",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final createAccountButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Criar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Nova conta'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => runApp(Orion()),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getLogo(),
                      emailField,
                      SizedBox(height: 5.0),
                      passwordField,
                      SizedBox(
                        height: 5.0,
                      ),
                      confirmPasswordField,
                      SizedBox(
                        height: 25.0,
                      ),
                      createAccountButton,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
