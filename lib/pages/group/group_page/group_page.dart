import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';

class GroupPage extends StatefulWidget {
  final group;

  GroupPage(this.group);

  @override
  _GroupPageState createState() => _GroupPageState(group);
}

class _GroupPageState extends State<GroupPage> {
  Group group;

  _GroupPageState(this.group);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8893f2),
          title: Text(group.name),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Text('Feed'),
              Text('Participantes'),
              Text('Eventos'),
              Text('Infos'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
