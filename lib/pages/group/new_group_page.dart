import 'package:flutter/material.dart';
import 'package:orion/components/login/login_components.dart';

class NewGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Novo Grupo',
          style: TextStyle(
            color: Colors.black
          ),
          ),
      ),
      body: getNewGroupForm(context),
    );
  }
}


Widget getNewGroupForm(BuildContext context) {
  final createButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
        },
        child: Text("Criar",
            textAlign: TextAlign.center,
            style: getTextStyle().copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        getTextField('Instituição'),
        getTextField('Curso'),
        getTextField('Disciplina'),
        getTextField('Grupo'),
        createButton,
      ],
    ),
  );
}