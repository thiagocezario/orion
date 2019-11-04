import 'package:flutter/material.dart';
import 'package:orion/actions/open_invite.dart';
import 'package:orion/pages/event/events_page.dart';
import 'package:orion/pages/group/groups_page.dart';
import 'package:orion/pages/group/search_group_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool opend = false;

  var _title = Text(
    'Orion',
    style: TextStyle(color: Colors.black),
  );

  void checkInvite() {
    if (opend) {
      return;
    }

    openInvite(context).then((eesponse) => opend = true);
  }

  @override
  Widget build(BuildContext context) {
    checkInvite();

    final List<Widget> _children = [
      Container(
        child: GroupsPage(),
      ),
      Container(
        child: EventsPage(),
      ),
      Container(
        child: SearchGroupPage(),
      ),
      Container()
    ];

    final AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff8893f2),
      elevation: 0.0,
      centerTitle: false,
      title: _title,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.terrain),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        //selectedItemColor: Colors.green,
        selectedItemColor: Color(0xff8893f2),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Início',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text(
              'Eventos',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Grupos',
            ),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
