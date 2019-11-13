import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  GroupCard({this.group});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.discipline.name),
      //isThreeLine: true,
      trailing: Column(
        children: <Widget>[
          Icon(Icons.person),
          Text(group.metadata.subscriptions.toString())
        ],
      ),
    );
  }
}
