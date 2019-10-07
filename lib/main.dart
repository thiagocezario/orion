import 'package:flutter/material.dart';
import 'package:orion/pages/login/login_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:orion/provider/auth_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
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
          ChangeNotifierProvider(builder: (context) => GroupEventsProvider()),
          ChangeNotifierProvider(builder: (context) => SubscriptionsProvider()),
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
          home: SplashScreen(
            seconds: 20,
            backgroundColor: Colors.white,
            imageBackground: AssetImage('assets/background/orion.jpg'),
            image: Image.asset(
              'assets/logo/orionlogo.png',
              fit: BoxFit.fill,
              height: 150,
              width: 150,
              scale: 100.0,

            ),
            loaderColor: Colors.white,
            loadingText: Text(
              'Carregando...',
              style: TextStyle(color: Colors.white),
            ),
            title: Text(
              'Bem vindo!',
              style: TextStyle(color: Colors.white),
            ),
            navigateAfterSeconds: LoginPage(),
          ),
        ));
  }
}
