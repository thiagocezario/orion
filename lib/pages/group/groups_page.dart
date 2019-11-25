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
  Widget recomendationsList(GroupRecomendationsProvider recommendations) {
    int length = recommendations.groupRecomendations.length;
    if (length == 0) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(bottom: 5),
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: GroupRecommendations(recommendations.groupRecomendations),
    );
  }

  Widget groupsList(MyGroupsProvider myGroupsState) {
    int length = myGroupsState.myGroups.length;
    if (length == 0) {
      return Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        child: Text(
          'Você ainda não se inscreveu em nenhum grupo.',
          style: TextStyle(
            fontFamily: 'Avenir',
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      );
    }

    return Expanded(
      child: GroupCardsList(myGroupsState.myGroups),
    );
  }

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
                recomendationsList(recommendations),
                groupsList(myGroupsState),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
