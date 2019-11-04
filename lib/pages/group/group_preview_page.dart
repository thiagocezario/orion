import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/main.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/post.dart';
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

  Widget subIcon(Subscription sub) {
    String subscriptionRole = 'Membro';
    Icon subscriptionIcon = Icon(Icons.person);

    if (sub.manager) {
      subscriptionIcon = Icon(
        Icons.people,
        color: Colors.green,
      );

      subscriptionRole = 'Admin';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        subscriptionIcon,
        Text(
          subscriptionRole,
          style: TextStyle(color: Colors.green),
        )
      ],
    );
  }

  SliverList _getPostsPreview(List<Post> posts) {
    if (posts.length == 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Não existem publicações feitas neste grupo.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  enabled: false,
                ),
                Divider(),
              ],
            );
          },
          childCount: 1,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index > 3 || index + 1 > posts.length) {
            return null;
          }

          return Column(
            children: <Widget>[
              Text(".. x stars"),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  size: 25,
                ),
                title: Text(posts[index].title),
                subtitle: Text(
                  posts[index].content,
                ),
              ),
              Text("Attachments: ${posts[index].blobs.length}"),
              Divider(),
            ],
          );
        },
        childCount: posts.length,
      ),
    );
  }

  SliverList _getSubscriptionsPreview(List<Subscription> subscriptions) {
    if (subscriptions.length == 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Não existem usuários cadastrados neste grupo.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  enabled: false,
                ),
                Divider(),
              ],
            );
          },
          childCount: 1,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index > 3 || index + 1 > subscriptions.length) {
            return null;
          }

          return Column(
            children: <Widget>[
              ListTile(
                leading: subIcon(subscriptions[index]),
                title: Text(subscriptions[index].student.name),
                subtitle: Text(subscriptions[index].student.email),
              ),
              Divider(),
            ],
          );
        },
        childCount: subscriptions.length,
      ),
    );
  }

  SliverList _getEventsPreview(List<Event> events) {
    if (events.length == 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Não existem eventos cadastrados neste grupo.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  enabled: false,
                ),
                Divider(),
              ],
            );
          },
          childCount: 1,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index > 3 || index + 1 > events.length) {
            return null;
          }

          DateTime date = DateFormat("yyyy-MM-dd hh:mm:ss")
              .parse(events[index].date.toString());

          return Column(
            children: <Widget>[
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 25,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "${date.day}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 25,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          DateFormat.MMM().format(date),
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(events[index].title),
                subtitle: Text(
                  events[index].content,
                ),
              ),
              Divider(),
            ],
          );
        },
        childCount: events.length,
      ),
    );
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
              backgroundColor: primaryColor,
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
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
                      );
                    },
                    childCount: 1,
                  ),
                ),
                _getPostsPreview(groupPostsProvider.groupPosts),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
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
                      );
                    },
                    childCount: 1,
                  ),
                ),
                _getSubscriptionsPreview(subscriptionsProvider.subscriptions),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
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
                      );
                    },
                    childCount: 1,
                  ),
                ),
                _getEventsPreview(groupEventsProvider.groupEvents),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
