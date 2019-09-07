import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionFieldController = TextEditingController();
  final _courseFieldController = TextEditingController();
  final _classFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xff8893f2),
          appBar: getAppBar(context),
          body: ListView(
            children: <Widget>[
              _buildForm(context),
            ],
          )),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getTitleMessage('Novo grupo', Colors.black),
            SizedBox(
              height: 50.0,
            ),
            getTextField('Instituição', _institutionFieldController),
            SizedBox(
              height: 10.0,
            ),
            getTextField('Curso', _courseFieldController),
            SizedBox(
              height: 10.0,
            ),
            getTextField('Disciplina', _classFieldController),
            SizedBox(
              height: 25.0,
            ),
            getMaterialButton(context, _formKey, 'Criar', () {}),
          ],
        ),
      ),
    );
  }
}
