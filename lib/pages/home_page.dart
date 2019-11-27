import 'package:flutter/material.dart';
import 'package:orion/actions/store_user.dart';
import 'package:orion/components/origin_consumer.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/event/events_page.dart';
import 'package:orion/pages/group/groups_page.dart';
import 'package:orion/pages/group/search_group_page.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;

  final List<Widget> tabContents = [
    Container(
      key: UniqueKey(),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: GroupsPage(),
      ),
    ),
    Container(
      key: UniqueKey(),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: EventsPage(),
      ),
    ),
    Container(
      key: UniqueKey(),
      child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: SearchGroupPage(),
      ),
    ),
  ];

  final List<Widget> tabs = [
    Tab(
      icon: Icon(Icons.home),
    ),
    Tab(
      icon: Icon(Icons.calendar_today),
    ),
    Tab(
      icon: Icon(Icons.search),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget getHomePage() {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: TabBar(
              controller: _tabController,
              tabs: tabs,
              labelColor: Colors.white,
              unselectedLabelColor: darkGreyColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: darkGreyColor,
            ),
            backgroundColor: themeColor,
            actions: <Widget>[
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return ["Alterar Senha", "Deslogar"]
                      .map(
                        (String value) => PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList();
                },
                onSelected: (String selection) {
                  if (selection == "Alterar Senha") {
                    Navigator.of(context).pushNamed(ChangePasswordPageRoute);
                  } else if (selection == "Deslogar") {
                    storeUser(User(), "");
                    Navigator.of(context).pushNamed(LoginPageRoute);
                  }
                },
              ),
            ],
          ),
          body: Stack(children: <Widget>[
            TabBarView(
              children: tabContents,
              controller: _tabController,
            ),
            Container(
              padding: EdgeInsets.only(left: 50),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                color: themeColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  HomeTile(
                    controller: _tabController,
                  ),
                  Container()
                ],
              ),
            ),
          ]),
          backgroundColor: themeColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OriginConsumer(
      child: getHomePage(),
    );
  }
}

class HomeTile extends StatefulWidget {
  final TabController controller;

  HomeTile({Key key, this.controller}) : super(key: key);

  @override
  HomeTileState createState() => HomeTileState(controller: controller);
}

class HomeTileState extends State<HomeTile> {
  final TabController controller;
  int _currentIndex = 0;
  bool checked = false;
  double value = 0;

  HomeTileState({this.controller});

  final List<Widget> tabTitles = [
    Text(
      'Meus Grupos',
      style: mainTitleStyle,
    ),
    Text(
      'Próximos Eventos',
      style: mainTitleStyle,
    ),
    Text(
      'Buscar Grupos',
      style: mainTitleStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(_setActiveTabIndex);
    // controller.animation.addListener(listenera);
  }

  void _setActiveTabIndex() {
    setState(() {
      checked = false;
      _currentIndex = controller.index;
    });
  }

  void listenera() {
    int currentDirection = controller.animation.value > value ? 1 : -1;
    value = controller.animation.value;

    if (_currentIndex == controller.index && !checked) {
      setState(() {
        _currentIndex += currentDirection;
      });
    } else if (_currentIndex > controller.index && currentDirection < 0) {
      setState(() {
        checked = true;
        _currentIndex = controller.index;
      });
    } else if (_currentIndex < controller.index && currentDirection > 0) {
      setState(() {
        checked = true;
        _currentIndex = controller.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return tabTitles[_currentIndex];
  }
}
