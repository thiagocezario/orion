
import 'package:flutter/material.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/home_page.dart';
import 'package:orion/pages/login/login_page.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/origin_provider.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

import 'actions/store_user.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget page;

  @override
  void initState() {
    loadPage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadHomePage() {
    Provider.of<MyGroupsProvider>(context).refreshMyGroups();
    Provider.of<GroupRecomendationsProvider>(context).refreshMyRecomendations();
    Provider.of<MyEventsProvider>(context).fetchEvents();
    Provider.of<SearchGroupsProvider>(context).refreshInstitutions();
  }

  loadPage() {
    getStoredUser().then((a) {
      String token = Singleton().jwtToken;

      setState(() {
        //page = LoginPage();
        page = token != null && token.length > 0 ? toHome() : LoginPage();
      });
    });
  }

  Widget toHome() {
    loadHomePage();

    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OriginProvider>(context).init();

    return Container(
      color: themeColor,
      child: page ?? Container(color: themeColor),
    );
  }
}
