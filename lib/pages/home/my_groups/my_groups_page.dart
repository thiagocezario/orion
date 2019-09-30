import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';

class MyGroups extends StatefulWidget {
  void updateMyGroups() {
    _MyGroupsState().listGroups();
  }

  @override
  _MyGroupsState createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  static List<Group> _myGroups = List();

  void listGroups() async {
    await Client.listGroups(Singleton().jwtToken, Singleton().user.id)
        .then((response) {
      setState(() {
        String jsonResponse = response.body;
        _myGroups = groupFromJson(jsonResponse);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GroupCards().getGroupCards(context, _myGroups),
    );
  }
}
