import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';

class MyGroups extends StatefulWidget {
  @override
  _MyGroupsState createState() => _MyGroupsState(true);
}

class _MyGroupsState extends State<MyGroups> {
  List<Group> _myGroups = List();
  ListView _cardsList = ListView();
  bool shouldRefresh = true;

  _MyGroupsState(bool shouldRefresh) {
    this.shouldRefresh = shouldRefresh;
  }

  void listGroups() async {
    await Client.listGroups(Singleton().jwtToken, Singleton().user.id)
        .then((response) {
      setState(() {
        String jsonResponse = response.body;
        _myGroups = groupFromJson(jsonResponse);
        _cardsList = GroupCards().getGroupCards(context, _myGroups);
        shouldRefresh = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shouldRefresh) {
      listGroups();
    }
    
    return Container(
      alignment: Alignment.center,
      child: _cardsList,
    );
  }
}
