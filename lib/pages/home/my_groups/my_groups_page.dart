import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';

class MyGroups extends StatefulWidget {
  @override
  _MyGroupsState createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  GroupCards cards = GroupCards();
  List<Group> _myGroups;

  Widget _buildMyGroups() {
    Client.listGroups(Singleton().jwtToken, Singleton().user.id)
        .then((response) {
      String jsonResponse = response.body;
      _myGroups = groupFromJson(jsonResponse);

      return Container(
        alignment: Alignment.center,
        child: cards.getGroupCards(context, _myGroups),
      );
    });

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMyGroups();
  }
}
