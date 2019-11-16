import 'package:flutter/material.dart';
import 'package:orion/api/resources/ban_resource.dart';
import 'package:orion/api/resources/manager_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionMenu extends StatelessWidget {
  final Group group;
  final bool isUserManager;
  final Subscription subscription;

  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Tornar admin', 'Banir', 'Expulsar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();

  SubscriptionMenu(this.group, this.isUserManager, this.subscription);

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

  Widget _subscriptionAction(
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

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return _subscriptionAction(context, subscription);
  }
}
