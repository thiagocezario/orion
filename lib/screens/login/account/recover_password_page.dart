import 'package:flutter/material.dart';
import '../../../main.dart';
import '../login_page.dart';

class RecoverPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orion',
      home: EmailForm(title: 'Recuperar senha'),
    );
  }
}


class EmailForm extends StatefulWidget {
  EmailForm({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final recoverPasswordButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Recuperar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Recuperar Senha'),
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
                      SizedBox(
                        height: 25.0,
                      ),
                      recoverPasswordButton
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

RaisedButton getRaisedButton() {
  return RaisedButton(
      color: Colors.white54,
      elevation: 10.0,
      child: Text('Logar'),
      onPressed: () => runApp(LoginPage()));
}