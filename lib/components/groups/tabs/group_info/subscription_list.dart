import 'package:flutter/material.dart';
import 'package:orion/api/resources/ban_resource.dart';
import 'package:orion/api/resources/manager_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

import '../../subscription_icon.dart';

class SubscriptionList extends StatelessWidget {
  final bool isUserManager;
  final List<Subscription> subscriptions;
  final Group group;
  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Tornar admin', 'Banir', 'Expulsar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();

  SubscriptionList(this.subscriptions, this.group, this.isUserManager);

  Future _popUpMenuActions(
      BuildContext context, String action, Subscription sub) async {
    if (action == 'Tornar admin') {
      ManagerResource.createObject(sub).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    } else if (action == 'Banir') {
      BanResource.createObject(sub).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    } else if (action == 'Expulsar') {
      SubscriptionResource.unsubscribe(sub.id.toString()).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    } else if (action == "Desbanir") {
      BanResource.deleteObject(sub).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    }
  }

  PopupMenuButton<String> subscriptionAction(
      BuildContext context, Subscription sub) {
    if (isUserManager) {
      if (sub.banned) {
        return PopupMenuButton<String>(
          onSelected: (String actionSelected) =>
              _popUpMenuActions(context, actionSelected, sub),
          itemBuilder: (BuildContext context) {
            return <String>['Desbanir', 'Expulsar']
                .map((String value) => PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList();
          },
        );
      } else {
        return PopupMenuButton<String>(
          onSelected: (String actionSelected) =>
              _popUpMenuActions(context, actionSelected, sub),
          itemBuilder: (BuildContext context) => _popUpMenuItems,
        );
      }
    }

    return null;
  }

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
                    trailing:
                        subscriptionAction(context, subscriptions[index]));
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
                        color: Colors.red,
                      ),
                    ),
                    subtitle: Text(
                      subscriptions[index].student.email,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    trailing:
                        subscriptionAction(context, subscriptions[index]));
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
