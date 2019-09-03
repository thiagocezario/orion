import 'package:flutter/material.dart';
import 'package:orion/components/login/form_items/form_items.dart';

Widget getNewGroupForm(BuildContext context, GlobalKey<FormState> _formKey) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        getTitleMessage('Novo grupo', Colors.black),
        SizedBox(height: 50.0,),
        getTextField('Nome do grupo'),
        SizedBox(height: 10.0,),
        getTextField('Instituição'),
        SizedBox(height: 10.0,),
        getTextField('Curso'),
        SizedBox(height: 10.0,),
        getTextField('Disciplina'),
        SizedBox(height: 25.0,),
        getMaterialButton(context, _formKey, 'Criar', () {}),
      ],
    ),
    ),
  );
}