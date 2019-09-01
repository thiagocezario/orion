import 'package:flutter/material.dart';
import 'package:orion/components/login/login_components.dart';

class RecoverPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orion',
        home: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text('Redefinir Senha', style: TextStyle(color: Colors.black),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black,),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: EmailForm(title: 'Redefinir senha')));
  }
}

class EmailForm extends StatefulWidget {
  EmailForm({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {

  @override
  Widget build(BuildContext context) {
    final recoverPasswordButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Redefinir senha",
            textAlign: TextAlign.center,
            style: getTextStyle().copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return ListView(
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
                  getTextField('Email'),
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
    );
  }
}