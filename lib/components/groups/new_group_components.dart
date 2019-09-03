import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';

Widget getNewGroupForm(BuildContext context, GlobalKey<FormState> _formKey) {
  final controller = TextEditingController();

  return Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        getTitleMessage('Novo grupo', Colors.black),
        SizedBox(height: 50.0,),
        getTextField('Nome do grupo', controller),
        SizedBox(height: 10.0,),
        getTextField('Instituição', controller),
        SizedBox(height: 10.0,),
        getTextField('Curso', controller),
        SizedBox(height: 10.0,),
        getTextField('Disciplina', controller),
        SizedBox(height: 25.0,),
        getMaterialButton(context, _formKey, 'Criar', () {}),
      ],
    ),
    ),
  );
}