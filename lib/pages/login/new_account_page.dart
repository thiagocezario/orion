import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/login/form_items/form_items.dart';
import 'package:orion/components/login/new_account_components.dart';

class NewAccountPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xff8893f2),
            appBar: getAppBar(context),
            body: ListView(
              children: <Widget>[
                getNewAccountForm(context, _formKey)
              ],
            )
    );
  }
}