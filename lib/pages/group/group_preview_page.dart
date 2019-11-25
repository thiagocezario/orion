import 'package:flutter/material.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/groups/group_preview/group_events_preview.dart';
import 'package:orion/components/groups/group_preview/group_preview_posts.dart';
import 'package:orion/components/groups/tabs/group_info/subscriptions_preview.dart';
import 'package:orion/controllers/group_controller.dart';
import 'package:orion/main.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/group/group_page.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/preview_provider.dart';
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
        GroupController.refreshAll(context, group: group);

        Provider.of<GroupRecomendationsProvider>(context)
            .refreshMyRecomendations();
        Provider.of<MyGroupsProvider>(context).refreshMyGroups();

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
    return Consumer<PreviewProvider>(
      builder: (context, previewProvider, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: themeColor,
            title: Text(group.name),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'subscribe',
            tooltip: 'Ingressar',
            onPressed: () {
              _joinGroup(group);
            },
            backgroundColor: themeColor,
            child: Icon(Icons.add_circle_outline),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Membros', style: intraySubTitleStyle),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 15),
                sliver: SubscriptionsPreview(
                  previewProvider.subscriptions,
                  10,
                  group,
                  false,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Eventos', style: intraySubTitleStyle),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 15),
                sliver: GroupEventsPreview(previewProvider.events),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Publicações', style: intraySubTitleStyle),
                    ),
                  ],
                ),
              ),
              GroupPreviewPosts(previewProvider.posts, group),
            ],
          ),
        );
      },
    );
  }
}
