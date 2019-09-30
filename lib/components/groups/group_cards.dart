import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';

class GroupCards {
  static List<Group> groups = List<Group>();

  ListView getGroupCards(BuildContext context, List<Group> groups) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return _buildGroupCard(groups[index]);
        });
  }

  Widget _buildGroupCard(Group group) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Card(
            margin: EdgeInsets.all(7.5),
            elevation: 5.0,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
                    child: Text(
                      group.name.toUpperCase(),
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.0, bottom: 3.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.place),
                        Text(group.institution.name)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.person),
                        Text(group.metadata.subscriptions.toString())
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
