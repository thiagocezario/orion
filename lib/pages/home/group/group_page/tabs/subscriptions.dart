import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class GroupUsers extends StatefulWidget {
  final Group group;

  GroupUsers(this.group);

  @override
  _GroupUsersState createState() => _GroupUsersState(group);
}

class _GroupUsersState extends State<GroupUsers> {
  final Group group;

  _GroupUsersState(this.group);

  @override
  Widget build(BuildContext context) {
    IconButton subscriptionActions(Subscriptions subscription) {
      if (subscription.student.id == 2) {
        return IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        );
      }

      return null;
    }

    return Consumer<SubscriptionsProvider>(
      builder: (context, subscriptionsState, _) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: subscriptionsState.subscriptions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subscriptionsState.subscriptions[index].student.name),
            subtitle:
                Text(subscriptionsState.subscriptions[index].student.email),
            trailing:
                subscriptionActions(subscriptionsState.subscriptions[index]),
          );
        },
      ),
    );
  }
}
