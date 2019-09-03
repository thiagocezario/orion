import 'package:flutter/material.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/pages/group/new_group_page.dart';

enum TabItem { myGroups, groups, community, profile }

// class Home extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => HomeState();

// }

// class HomeState extends State<Home> {
//   TabItem currentTab = TabItem.myGroups;

//   void _selectedTab(TabItem tab) {
//     setState(() {
//       currentTab = tab;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(),
//       bottomNavigationBar: BottomNavigation(
//         currentTab: currentTab,
//         onSelected: _selectTab,
//       )
//     );
//   }

//   Widget _buildBody() {
//     return Container(
//       alignment: Alignment.center,
//       child: getListOfGroups(context),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  final List<Widget> items;
  HomePage({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'Meus Grupos',
              style: TextStyle(color: Colors.black),
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
          body: getListOfGroups(context),
          bottomNavigationBar: BottomNavigationBar(
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
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            elevation: 15.0,
            backgroundColor: Colors.green,
            onPressed: () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewGroupPage()),
                );
              }
            },
          ),
        ));
  }
}
