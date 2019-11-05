import 'package:flutter/material.dart';
import 'package:orion/components/groups/subscription_icon.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionsPreview extends StatelessWidget {
  final List<Subscription> subscriptions;

  SubscriptionsPreview(this.subscriptions);

  @override
  Widget build(BuildContext context) {
    int subCount = subscriptions.length > 10 ? 10 : subscriptions.length;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            leading: SubscriptionIcon(subscriptions[index]),
            title: Text(
              subscriptions[index].student.name,
            ),
            subtitle: Text(
              subscriptions[index].student.email,
            ),
          );
        },
        childCount: subCount,
      ),
    );
  }
}
