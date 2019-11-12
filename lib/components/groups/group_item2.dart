import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/group.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  GroupCard(this.group);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
      elevation: 1.0,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0,),
                    child: Text(
                      group.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, bottom: 10.0, top: 10.0, right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${group.metadata.subscriptions}",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.people,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 13.0, bottom: 3.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: groupIconsColor,
                  ),
                  Expanded(
                    child: Text(
                      group.institution.name,
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.desktop_windows,
                    color: groupIconsColor,
                  ),
                  Expanded(
                    child: Text(
                      group.discipline.name,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
