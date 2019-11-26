import 'package:flutter/material.dart';
import 'package:orion/api/resources/ban_resource.dart';
import 'package:orion/api/resources/manager_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionMenu extends StatelessWidget {
  final Group group;
  final Subscription subscription;

  final List<String> _normalOptions = <String>[
    'Expulsar',
    'Banir',
  ];

  final List<String> _bannedOptions = <String>[
    'Desbanir',
  ];

  final List<String> _managerOptions = <String>[
    'Remover admin',
  ];

  final List<String> _notManagerOptions = <String>[
    'Tornar admin',
  ];

  SubscriptionMenu(this.group, this.subscription);

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
    } else if (action == "Remover admin") {
      ManagerResource.deleteObject(sub).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    }
  }

  bool isUserManager(BuildContext context) {
    MyGroupsProvider provider = Provider.of<MyGroupsProvider>(context);
    Subscription subscription = provider.subscriptionForGroup(group);

    return subscription != null && subscription.manager;
  }

  List<PopupMenuItem<String>> _popupOptions(Subscription subscription) {
    List<String> base = List<String>();

    if (subscription.banned) {
      base..addAll(_bannedOptions);
    } else {
      base..addAll(_normalOptions);
      if (subscription.manager) {
        base..addAll(_managerOptions);
      } else {
        base..addAll(_notManagerOptions);
      }
    }

    return base
        .map(
          (String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
  }

  Widget _subscriptionAction(BuildContext context, Subscription sub) {
    if (!isUserManager(context)) {
      return SizedBox();
    }

    return PopupMenuButton<String>(
      onSelected: (String actionSelected) =>
          _popUpMenuActions(context, actionSelected, subscription),
      itemBuilder: (BuildContext context) {
        return _popupOptions(subscription);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _subscriptionAction(context, subscription);
  }
}
