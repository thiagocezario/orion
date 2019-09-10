import 'package:flutter/material.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/pages/group/new_group_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  GroupCards cards = GroupCards();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      _buildMyGroups(),
      Container(),
      Container(
        child: NewGroupPage(),
      ),
      Container()
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.group,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Meus grupos',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ))
            ],
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
                  title: Text('Início')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.question_answer,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  title: Text('Comunidade')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
                  title: Text('Grupos')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Color.fromARGB(255, 0, 0, 0)),
                  title: Text('Perfil'))
            ],
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildMyGroups() {
    return Container(
      alignment: Alignment.center,
      child: cards.getGroupCards(context),
    );
  }
}
