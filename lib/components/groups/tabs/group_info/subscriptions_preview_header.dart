import 'package:flutter/material.dart';
import 'package:orion/components/groups/tabs/group_info/subscriptions_search.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SubscriptionsPreviewHeader extends StatelessWidget {
  final List<Subscription> subscriptions;
  final Group group;

  SubscriptionsPreviewHeader({this.group, this.subscriptions});

  void _searchUsers(BuildContext context) {
    showSearch(
      context: context,
      delegate: SubscriptionsSearch(group),
    );
  }

  bool isUserManager(BuildContext context) {
    MyGroupsProvider provider = Provider.of<MyGroupsProvider>(context);
    Subscription subscription = provider.subscriptionForGroup(group);

    return subscription != null && subscription.manager;
  }

  Widget inviteButton(BuildContext context) {
    if (!isUserManager(context) && group.isPrivate) {
      return SizedBox();
    }
    return InkWell(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.group_add,
            size: 30,
          ),
        ),
        title: Text("Convidar para grupo"),
      ),
      onTap: () {
        Share.share(
            'Você foi convidado para fazer parte do grupo ${group.name}! Tenha acesso a conteúdos e eventos da disciplina ${group.discipline.name}.\n${group.link()}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("${subscriptions.length} participantes"),
            trailing: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.lightBlueAccent,
              ),
              onPressed: () => _searchUsers(context),
            ),
          ),
          inviteButton(context),
        ],
      ),
    );
  }
}
