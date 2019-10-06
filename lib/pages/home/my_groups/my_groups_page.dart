import 'package:flutter/widgets.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class MyGroups extends StatefulWidget {
  @override
  _MyGroupsState createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, myGroupsState, _) => Container(
        alignment: Alignment.center,
        child: GroupCards().getGroupCards(context, myGroupsState.myGroups),
      ),
    );
  }
}
