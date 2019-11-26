import 'package:flutter/material.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionIcon extends StatelessWidget {
  final Subscription sub;

  SubscriptionIcon(this.sub);

  Widget _subscriptionIcon(Subscription sub) {
    if (sub.manager) return _managerIcon();
    return _memberIcon();
  }

  Color _statusColor() {
    if (sub.banned) return Colors.red[300];
    if (sub.manager) return Colors.green;
    return Colors.black;
  }

  Widget _managerIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          sub.banned? Icons.block : Icons.person,
          color: _statusColor(),
        ),
        Text(
          sub.banned? 'Banido' : 'Admin',
          style: TextStyle(color: _statusColor()),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _memberIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          sub.banned? Icons.block : Icons.person,
          color: _statusColor(),
        ),
        Text(
          sub.banned? 'Banido' : 'Membro',
          textAlign: TextAlign.center,
          style: TextStyle(color: _statusColor()),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _subscriptionIcon(sub);
  }
}
