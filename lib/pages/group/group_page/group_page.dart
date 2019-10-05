import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/group/group_page/tabs/group_event.dart';
import 'package:orion/pages/group/group_page/tabs/group_info.dart';
import 'package:orion/pages/group/group_page/tabs/subscriptions.dart';

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
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8893f2),
          title: Text(group.name),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Icon(Icons.home),
              Icon(Icons.people),
              Icon(Icons.event_note),
              Icon(Icons.score),
              Icon(Icons.info),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(),
            GroupUsers(group),
            GroupEvent(group),
            Container(),
            GroupInfo(group.id),
          ],
        ),
      ),
    );
  }
}
