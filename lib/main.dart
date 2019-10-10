import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/pages/login/login_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:orion/provider/auth_provider.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
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
        ChangeNotifierProvider(builder: (context) => GroupRecomendationsProvider()),
        // ChangeNotifierProvider(builder: (context) => SearchGroupsProvider()),
        ChangeNotifierProvider(builder: (context) => MyEventsProvider()),
        ChangeNotifierProvider(builder: (context) => GroupPostsProvider()),
        ChangeNotifierProvider(builder: (context) => GroupEventsProvider()),
        ChangeNotifierProvider(builder: (context) => DisciplinePerformancesProvider()),
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
          home: SplashScreen(
            seconds: 5,
            backgroundColor: primaryColor,
            photoSize: 150,
            loaderColor: Colors.white,
            image: Image.asset(
              'assets/logo/orionlogo.png',
            ),
            navigateAfterSeconds: LoginPage(),
          ),
        ));
  }
}
