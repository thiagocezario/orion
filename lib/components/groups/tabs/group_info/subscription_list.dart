import 'package:flutter/material.dart';
import 'package:orion/components/groups/subscription_menu.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';

import '../../subscription_icon.dart';

class SubscriptionList extends StatelessWidget {
  final Group group;
  final List<Subscription> subscriptions;

  SubscriptionList(this.subscriptions, this.group);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (!subscriptions[index].banned && subscriptions[index].active) {
                return ListTile(
                  leading: SubscriptionIcon(subscriptions[index]),
                  title: Text(subscriptions[index].student.name),
                  subtitle: Text(subscriptions[index].student.email),
                  trailing: SubscriptionMenu(
                    group,
                    subscriptions[index],
                  ),
                );
              }

              return SizedBox();
            },
            childCount: subscriptions.length,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (subscriptions[index].banned) {
                return ListTile(
                  leading: SubscriptionIcon(subscriptions[index]),
                  title: Text(
                    subscriptions[index].student.name,
                    style: TextStyle(
                      color: Colors.red[300],
                    ),
                  ),
                  subtitle: Text(
                    subscriptions[index].student.email,
                    style: TextStyle(
                      color: Colors.red[300],
                    ),
                  ),
                  trailing: SubscriptionMenu(
                    group,
                    subscriptions[index],
                  ),
                );
              }

              return SizedBox();
            },
            childCount: subscriptions.length,
          ),
        ),
      ],
    );
  }
}
