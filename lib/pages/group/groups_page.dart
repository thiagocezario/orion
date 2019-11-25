import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/components/groups/group_recomendations.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, myGroupsState, _) =>
          Consumer<GroupRecomendationsProvider>(
        builder: (context, recommendations, _) => Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  // color: Colors.black,
                  padding: EdgeInsets.only(bottom: 5),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child:
                      GroupRecommendations(recommendations.groupRecomendations),
                ),
                Expanded(
                  child: GroupCardsList(myGroupsState.myGroups),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
