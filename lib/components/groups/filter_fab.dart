import 'package:flutter/material.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/group/new_group_page.dart';

class FilterFloatingButton extends StatelessWidget {
  final Group group;

  FilterFloatingButton(this.group);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 15.0,
      backgroundColor: themeColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewGroupPage(
              group: group,
            ),
          ),
        );
      },
    );
  }
}
