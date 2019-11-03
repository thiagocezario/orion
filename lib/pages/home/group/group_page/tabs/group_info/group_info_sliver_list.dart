import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';

class GroupInfoSliverList extends StatelessWidget {
  final Group group;

  GroupInfoSliverList(this.group);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.school),
            title: Text(
              group.institution.name,
              textAlign: TextAlign.justify,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text(
              group.course.name,
              textAlign: TextAlign.justify,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.class_),
            title: Text(
              group.discipline.name,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
