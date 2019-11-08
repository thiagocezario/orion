import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/group/group_page.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class GroupCardsList extends StatelessWidget {
  final List<Group> groups;

  GroupCardsList(this.groups);

  Widget _buildGroupCard(BuildContext context, Group group) {
    return Material(
      child: InkWell(
        onTap: () async {
          Provider.of<GroupPostsProvider>(context)
              .fetchPosts(group.id.toString());
          Provider.of<SubscriptionsProvider>(context)
              .fetchSubscriptions(group.id.toString());
          Provider.of<GroupEventsProvider>(context)
              .fetchEvents(group.id.toString());
          Provider.of<DisciplinePerformancesProvider>(context)
              .fetchPerformances(group.discipline.id.toString());

          var data = {
            'group_id': group.id.toString(),
            'user_id': Singleton().user.id.toString()
          };
          await SubscriptionResource.list(data).then((response) {
            var sub = subscriptionFromJson(response.body);

            if (sub.first.student.id == Singleton().user.id &&
                sub.first.manager) {
              GroupPage.isUserManager = true;
            } else {
              GroupPage.isUserManager = false;
            }
          });

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GroupPage(group)));
        },
        child: GroupCard(group),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return _buildGroupCard(context, groups[index]);
        });
  }
}

class GroupCard extends StatelessWidget {
  final Group group;

  GroupCard(this.group);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7.5),
      elevation: 5.0,
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
                        EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
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
                      SizedBox(width: 5.0,),
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
