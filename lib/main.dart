import 'package:flutter/material.dart';
import 'package:orion/pages/login/login_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:provider/provider.dart';

import 'api/authentication/auth_provider.dart';

void main() => runApp(Orion());

class Orion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (context) => AuthProvider(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/new_account': (context) => NewAccountPage(),
            '/recover_password': (context) => RecoverPasswordPage()
          },
          debugShowCheckedModeBanner: false,
          title: 'Orion',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
        ));
  }
}
