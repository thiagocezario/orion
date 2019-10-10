import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/home/group/group_page/group_page.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class GroupCards {
  static List<Group> groups = List<Group>();

  ListView getGroupCards(BuildContext context, List<Group> groups) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return _buildGroupCard(context, groups[index]);
        });
  }

  Widget _buildGroupCard(BuildContext context, Group group) {
    return Material(
      child: InkWell(
        onTap: () {
          Provider.of<GroupPostsProvider>(context).fetchPosts(group.id.toString());
          Provider.of<SubscriptionsProvider>(context).fetchSubscriptions(group.id.toString());
          Provider.of<GroupPostsProvider>(context).fetchPosts(group.id.toString());
          Provider.of<GroupEventsProvider>(context).fetchEvents(group.id.toString());
          Provider.of<DisciplinePerformancesProvider>(context).fetchPerformances(group.discipline.id.toString());

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GroupPage(group)));
        },
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
