import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orion/main.dart';
import 'package:orion/screens/home/mock/group_mock.dart';

class HomePage extends StatelessWidget {
  final List<Widget> items;
  HomePage({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text('Grupos'),
            leading: IconButton(
              icon: BackButton(),
              onPressed: () => runApp(Orion()),
            ),
            actions: <Widget>[Icon(Icons.search)],
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
      padding: EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueGrey],
                tileMode: TileMode.clamp)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
              child: Text(
                group.groupName.toUpperCase(),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.place),
                  Text(group.institutionName)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text(group.numberOfParticipants.toString()),
                  SizedBox(
                    width: 160.0,
                  ),
                  Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white54,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          "Ingressar",
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