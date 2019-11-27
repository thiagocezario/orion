import 'package:flutter/material.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  GroupCard({this.group});

  Widget name() {
    return Text(group.name);
  }

  Widget title() {
    if (group.isPrivate) {
      return Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.lock_outline,
              color: themeColor,
              size: 15,
            ),
          ),
          Expanded(child: name(),)
        ],
      );
    }

    return name();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title(),
      subtitle: Text(group.discipline.name),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.person),
          Text(group.metadata.subscriptions.toString()),
        ],
      ),
    );
  }
}
