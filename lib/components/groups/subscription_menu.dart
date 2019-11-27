import 'package:flutter/material.dart';
import 'package:orion/controllers/subscription_controller.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/my_groups_provider.dart';
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
      SubscriptionController.createManager(context, subscription: subscription);
    } else if (action == 'Banir') {
      SubscriptionController.ban(context, subscription: subscription);
    } else if (action == 'Expulsar') {
      SubscriptionController.remove(context, subscription: subscription);
    } else if (action == "Desbanir") {
      SubscriptionController.unban(context, subscription: subscription);
    } else if (action == "Remover admin") {
      SubscriptionController.removeManager(context, subscription: subscription);
    }
  }

  Subscription mySubscription(BuildContext context) {
    MyGroupsProvider provider = Provider.of<MyGroupsProvider>(context);

    return provider.subscriptionForGroup(group);
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
    Subscription my = mySubscription(context);
    bool isUserManager = my != null && my.manager;

    if (subscription.id == my.id) {
      // return Text('Você', textAlign: TextAlign.center, style: TextStyle(),);
      return Container(
        // color: Colors.black,
        padding: EdgeInsets.only(right: 8, left: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.fingerprint, color: themeColor),
            Text('Você')
          ],
        ),
      );
    }
    if (!isUserManager) {
      return SizedBox();
    }

    return Container(
      child: PopupMenuButton<String>(
        onSelected: (String actionSelected) =>
            _popUpMenuActions(context, actionSelected, subscription),
        itemBuilder: (BuildContext context) {
          return _popupOptions(subscription);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _subscriptionAction(context, subscription);
  }
}
