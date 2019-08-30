import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'group.dart';

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
            centerTitle: true,
            title: Text('Grupos'),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.search))
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
                  icon: Icon(Icons.people, color: Color.fromARGB(255, 0, 0, 0)),
                  title: Text('Grupos')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.question_answer, color: Color.fromARGB(255, 0, 0, 0)),
                  title: Text('Comunidade')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Color.fromARGB(255, 0, 0, 0)),
                  title: Text('Perfil'))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => {},
          ),
        ));
  }
}

ListView getListOfGroups(BuildContext context) {
  String json = getJsonData();
  List<Group> groups = groupFromJson(json);
  List<GroupCell> groupCells = getCells(groups);

  return ListView.builder(
    itemCount: groupCells.length,
    itemBuilder: (context, index) {
      return buildGroupCell(groupCells[index]);
    },
  );
}

List<GroupCell> getCells(List<Group> groups) {
  List<GroupCell> groupCells = new List();
  for (var group in groups) {
    GroupCell cell =
        GroupCell(group.name, group.institutionName, group.members.length);
    groupCells.add(cell);
  }

  return groupCells;
}

class GroupCell {
  final String groupName;
  final String institutionName;
  final int numberOfParticipants;

  GroupCell(this.groupName, this.institutionName, this.numberOfParticipants);
}

Widget buildGroupCell(GroupCell group) {
  return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 20.0,
                spreadRadius: 5.0,
                offset: Offset(
                  10.0,
                  10.0,
                ),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.lightGreenAccent, Colors.green])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
              child: Text(
                group.groupName.toUpperCase(),
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 13.0, top: 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.place),
                  Text(group.institutionName)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text(group.numberOfParticipants.toString()),
                  SizedBox(
                    width: 190.0,
                  ),
                  Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          "Juntar-se",
                          textAlign: TextAlign.center,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ));
}
