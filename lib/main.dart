import 'package:flutter/material.dart';
import 'package:orion/pages/login/login_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:orion/provider/auth_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

void main() => runApp(Orion());

class Orion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Singleton();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => AuthProvider()),
        ChangeNotifierProvider(builder: (context) => MyGroupsProvider()),
        // ChangeNotifierProvider(builder: (context) => SearchGroupsProvider()),
        ChangeNotifierProvider(builder: (context) => MyEventsProvider()),
        // ChangeNotifierProvider(builder: (context) => GroupEventsProvider()),
        // ChangeNotifierProvider(builder: (context) => GroupSubscriptionsProvider()),
      ],
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
