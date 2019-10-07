import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
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
  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Tornar admin', 'Banir', 'Expulsar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();

  _GroupUsersState(this.group);

  // TODO: Remover requisições desnecessarias
  Future _popUpMenuActions(String action, Subscription sub) async {
    if (action == 'Tornar admin') {
      await Client.createManager(Singleton().jwtToken, sub.id).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    } else if (action == 'Banir') {
      await Client.createBan(Singleton().jwtToken, sub.id).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    } else if (action == 'Expulsar') {
      await Client.unsubscribe(Singleton().jwtToken, sub.id).then((response) {
        Provider.of<SubscriptionsProvider>(context)
            .fetchSubscriptions(group.id.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: Limitar pra usuarios adm
    PopupMenuButton<String> subscriptionAction(Subscription sub) {
      if (!sub.manager) {
        return PopupMenuButton<String>(
          onSelected: (String actionSelected) =>
              _popUpMenuActions(actionSelected, sub),
          itemBuilder: (BuildContext context) => _popUpMenuItems,
        );
      }

      return null;
    }

    Widget subIcon(Subscription sub) {
      if (sub.manager) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.people,
              color: Colors.green,
            ),
            Text(
              'Admin',
              style: TextStyle(color: Colors.green),
            )
          ],
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person),
        ],
      );
    }

    return Consumer<SubscriptionsProvider>(
      builder: (context, subscriptionsState, _) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: subscriptionsState.subscriptions.length,
        itemBuilder: (context, index) {
          // TODO: Listar diferente os usuarios banidos
          if (!subscriptionsState.subscriptions[index].banned &&
              subscriptionsState.subscriptions[index].active) {
            return ListTile(
                leading: subIcon(subscriptionsState.subscriptions[index]),
                title:
                    Text(subscriptionsState.subscriptions[index].student.name),
                subtitle:
                    Text(subscriptionsState.subscriptions[index].student.email),
                trailing:
                    // subscriptionActions(subscriptionsState.subscriptions[index]),
                    subscriptionAction(
                        subscriptionsState.subscriptions[index]));
          }

          return SizedBox(
            height: 0,
            width: 0,
          );
        },
      ),
    );
  }
}
