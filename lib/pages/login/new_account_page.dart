import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/login/form_items/form_items.dart';
import 'package:orion/components/login/login_components.dart';
import 'package:orion/components/login/new_account_components.dart';

class NewAccountPage extends StatefulWidget {
  NewAccountPage({Key key}) : super(key: key);

  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orion',
        home: Scaffold(
          backgroundColor: Color(0xff8893f2),
            appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 0.0,
              backgroundColor: Color(0xff8893f2),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ListView(
              children: <Widget>[
                getNewAccountForm(context, _formKey)
              ],
            )
        )
    );
  }
}

/*
class NewAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            style: getTextStyle()
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orion',
        home: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              title: Text('Nova conta', style: TextStyle(color: Colors.black),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black,),
                onPressed: () => Navigator.pop(context),
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
                          getTextField('Email'),
                          SizedBox(height: 5.0),
                          getPasswordField('Senha'),
                          SizedBox(
                            height: 5.0,
                          ),
                          getPasswordField('Confirmar senha'),
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
            )));
  }
}
*/
