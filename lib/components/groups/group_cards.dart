import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orion/model/group.dart';

class GroupCards {
  static List<Group> groups = List<Group>();

  static Future loadGroupCards() async {
    try {
      String json = await rootBundle.loadString('assets/json/groups.json');
      groups = groupFromJson(json);
    } catch (e) {
      print(e);
    }
  }

  ListView getGroupCards(BuildContext context) {
    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return _buildGroupCard(groups[index]);
        });
  }

  Widget _buildGroupCard(Group group) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    3.0,
                    3.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightBlueAccent, Colors.blueAccent])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
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
                    Text(group.institutionName)
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
                    Text(group.members.length.toString())
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
