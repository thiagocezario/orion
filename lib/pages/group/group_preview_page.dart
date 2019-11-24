import 'package:flutter/material.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/groups/group_preview/group_events_preview.dart';
import 'package:orion/components/groups/group_preview/group_preview_posts.dart';
import 'package:orion/components/groups/tabs/group_info/subscriptions_preview.dart';
import 'package:orion/main.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/group/group_page.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class GroupPreviewPage extends StatefulWidget {
  final Group group;

  GroupPreviewPage(this.group);

  @override
  _GroupPreviewPageState createState() => _GroupPreviewPageState(group);
}

class _GroupPreviewPageState extends State<GroupPreviewPage> {
  final Group group;

  _GroupPreviewPageState(this.group);

  void _joinGroup(Group group) {
    SubscriptionResource.subscribe(group.id.toString()).then((response) async {
      if (response.statusCode == 201) {
        Provider.of<GroupRecomendationsProvider>(context)
            .refreshMyRecomendations();
        Provider.of<MyGroupsProvider>(context).refreshMyGroups();
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

        Navigator.of(context).popAndPushNamed(GroupPageRoute, arguments: group);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupPostsProvider>(
      builder: (context, groupPostsProvider, _) =>
          Consumer<SubscriptionsProvider>(
        builder: (context, subscriptionsProvider, _) =>
            Consumer<GroupEventsProvider>(
          builder: (context, groupEventsProvider, _) => Scaffold(
            appBar: AppBar(
              backgroundColor: themeColor,
              title: Text(group.name),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () => _joinGroup(group),
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Publicações',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                GroupPreviewPosts(groupPostsProvider.groupPosts, group),
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Usuários inscritos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                SubscriptionsPreview(
                  subscriptionsProvider.subscriptions,
                  3,
                  group,
                  false,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Eventos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                GroupEventsPreview(groupEventsProvider.groupEvents),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
