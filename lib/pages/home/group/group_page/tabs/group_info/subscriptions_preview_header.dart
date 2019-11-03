import 'package:flutter/material.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionsPreviewHeader extends StatelessWidget {
  final List<Subscription> subscriptions;

  SubscriptionsPreviewHeader(this.subscriptions);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("${subscriptions.length} participantes"),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.group_add,
                size: 30,
              ),
            ),
            title: Text("Convidar para grupo"),
          ),
        ],
      ),
    );
  }
}
