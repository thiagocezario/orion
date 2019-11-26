import 'package:flutter/material.dart';
import 'package:orion/components/empty_warning.dart';
import 'package:orion/components/groups/subscription_icon.dart';
import 'package:orion/components/groups/subscription_menu.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionsPreview extends StatelessWidget {
  final List<Subscription> subscriptions;
  final int previewSize;
  final Group group;

  SubscriptionsPreview(this.subscriptions, this.previewSize, this.group);

  @override
  Widget build(BuildContext context) {
    int subCount =
        subscriptions.length > previewSize ? previewSize : subscriptions.length;

    if (subCount == 0) {
      return SliverToBoxAdapter(
        child: ListTile(
          title: EmptyWarning(
            messsage: 'Nenhum estudante cadastrado neste grupo.',
          ),
          enabled: false,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (!subscriptions[index].banned && subscriptions[index].active) {
            return ListTile(
              leading: SubscriptionIcon(subscriptions[index]),
              title: Text(
                subscriptions[index].student.name,
              ),
              subtitle: Text(
                subscriptions[index].student.email,
              ),
              trailing: SubscriptionMenu(group, subscriptions[index]),
            );
          }

          return SizedBox();
        },
        childCount: subCount,
      ),
    );
  }
}
