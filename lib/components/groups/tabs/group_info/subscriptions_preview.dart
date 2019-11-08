import 'package:flutter/material.dart';
import 'package:orion/components/groups/subscription_icon.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionsPreview extends StatelessWidget {
  final List<Subscription> subscriptions;
  final int previewSize;

  SubscriptionsPreview(this.subscriptions, this.previewSize);

  @override
  Widget build(BuildContext context) {
    int subCount =
        subscriptions.length > previewSize ? previewSize : subscriptions.length;

    if (subCount == 0) {
      return SliverToBoxAdapter(
        child: ListTile(
          title: Text(
            'Não existem usuários cadastrados neste grupo.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
            ),
          ),
          enabled: false,
        ),
      );
    }

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
