import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/group/group_preview_page.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  Widget headerList(BuildContext context, List<Group> recommendations) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0
            ? const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 3.0, bottom: 30.0)
            : const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 3.0, bottom: 30.0);

        return Padding(
          padding: padding,
          child: InkWell(
            onTap: () {
              Provider.of<GroupPostsProvider>(context)
                  .fetchPosts(recommendations[index].id.toString());
              Provider.of<SubscriptionsProvider>(context)
                  .fetchSubscriptions(recommendations[index].id.toString());
              Provider.of<GroupEventsProvider>(context)
                  .fetchEvents(recommendations[index].id.toString());

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GroupPreviewPage(recommendations[index])));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(70),
                      offset: const Offset(3.0, 2.0),
                      blurRadius: 3)
                ],
              ),
              width: 350,
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '${recommendations[index].name}'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.people,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  '${recommendations[index].metadata.subscriptions}',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                Icon(
                                  Icons.people,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  '${recommendations[index].colleagues}',
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.place,
                              color: groupIconsColor,
                            ),
                            Expanded(
                              child: Text(
                                '${recommendations[index].institution.name}',
                                style: TextStyle(color: Colors.blueGrey),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.desktop_windows,
                              color: groupIconsColor,
                            ),
                            Expanded(
                              child: Text(
                                '${recommendations[index].discipline.name}',
                                style: TextStyle(color: Colors.blueGrey),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: recommendations.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, myGroupsState, _) =>
          Consumer<GroupRecomendationsProvider>(
        builder: (context, recommendations, _) => Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 8),
                          child: Text(
                            'Recomendações',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      child: headerList(
                          context, recommendations.groupRecomendations),
                    ),
                    Expanded(
                      child: GroupCardsList(myGroupsState.myGroups),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
