import 'package:flutter/material.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionIcon extends StatelessWidget {
  final Subscription sub;

  SubscriptionIcon(this.sub);

  Widget _subscriptionIcon(Subscription sub) {
    if (sub.manager) return _managerIcon();
    if (sub.banned) return _bannedIcon();
    return _memberIcon();
  }

  Widget _managerIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.person,
          color: Colors.green,
        ),
        Text(
          'Admin',
          style: TextStyle(color: Colors.green),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _memberIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.person),
        Text(
          'Membro',
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _bannedIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.person,
          color: Colors.red,
        ),
        Text(
          'Banido',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _subscriptionIcon(sub);
  }
}
