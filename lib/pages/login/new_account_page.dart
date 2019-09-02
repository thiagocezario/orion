import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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