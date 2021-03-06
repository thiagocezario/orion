import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:orion/landing_page.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/change_password_page.dart';
import 'package:orion/pages/group/group_page.dart';
import 'package:orion/pages/home_page.dart';
import 'package:orion/pages/login/login_page.dart';
import 'package:orion/pages/login/new_account_page.dart';
import 'package:orion/pages/login/recover_password_page.dart';
import 'package:orion/provider/auth_provider.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:orion/provider/download_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/origin_provider.dart';
import 'package:orion/provider/preview_provider.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

import 'components/posts/post_information.dart';

const String GroupPageRoute = '/group_page';
const String RecoverPasswordRoute = '/recover_password';
const String NewAccountRoute = '/new_account';
const String LoginPageRoute = '/login';
const String HomePageRoute = '/home';
const String LandingPageRoute = '/landing_page';
const String ChangePasswordPageRoute = '/change_password';
const String PostInformationPageRoute = '/post_information';

void main() =>
    initializeDateFormatting("pt_BR", null).then((_) => runApp(Orion()));

class Orion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Singleton();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => OriginProvider()),
          ChangeNotifierProvider(builder: (context) => AuthProvider()),
          ChangeNotifierProvider(builder: (context) => PreviewProvider()),
          ChangeNotifierProvider(builder: (context) => DownloadProvider()),
          ChangeNotifierProvider(builder: (context) => MyGroupsProvider()),
          ChangeNotifierProvider(builder: (context) => MyEventsProvider()),
          ChangeNotifierProvider(
              builder: (context) => GroupRecomendationsProvider()),
          ChangeNotifierProvider(builder: (context) => SearchGroupsProvider()),
          ChangeNotifierProvider(builder: (context) => GroupPostsProvider()),
          ChangeNotifierProvider(builder: (context) => GroupEventsProvider()),
          ChangeNotifierProvider(
              builder: (context) => DisciplinePerformancesProvider()),
          ChangeNotifierProvider(
              builder: (context) => DisciplineAbsencesProvider()),
          ChangeNotifierProvider(builder: (context) => SubscriptionsProvider()),
        ],
        child: MaterialApp(
          color: themeColor,
          initialRoute: LandingPageRoute,
          onGenerateRoute: generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Orion',
          home: LandingPage(),
        ));
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case GroupPageRoute:
      var arguments = settings.arguments;
      return MaterialPageRoute(builder: (context) => GroupPage(arguments));
    case NewAccountRoute:
      return MaterialPageRoute(builder: (context) => NewAccountPage());
    case RecoverPasswordRoute:
      return MaterialPageRoute(builder: (context) => RecoverPasswordPage());
    case LoginPageRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case LandingPageRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());
    case ChangePasswordPageRoute:
      return MaterialPageRoute(builder: (context) => ChangePasswordPage());
    case PostInformationPageRoute:
      var arguments = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PostInformation(arguments));
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
