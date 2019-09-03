import 'package:flutter/material.dart';
import 'package:orion/components/groups/new_group_components.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xff8893f2),
          appBar: AppBar(
            elevation: 0.0,
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
              getNewGroupForm(context, _formKey),
            ],
          )),
    );
  }
}
