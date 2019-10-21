import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/home/group/group_page/group_page.dart';
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
      await Client.createManager(Singleton().jwtToken, sub.id).then(
        (response) {
          Provider.of<SubscriptionsProvider>(context)
              .fetchSubscriptions(group.id.toString());
        },
      );
    } else if (action == 'Banir') {
      await Client.createBan(Singleton().jwtToken, sub.id).then(
        (response) {
          Provider.of<SubscriptionsProvider>(context)
              .fetchSubscriptions(group.id.toString());
        },
      );
    } else if (action == 'Expulsar') {
      await Client.unsubscribe(Singleton().jwtToken, sub.id).then(
        (response) {
          Provider.of<SubscriptionsProvider>(context)
              .fetchSubscriptions(group.id.toString());
        },
      );
    } else if (action == "Desbanir") {
      await Client.deleteBan(Singleton().jwtToken, sub.id).then(
        (response) {
          Provider.of<SubscriptionsProvider>(context)
              .fetchSubscriptions(group.id.toString());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Limitar pra usuarios adm
    PopupMenuButton<String> subscriptionAction(Subscription sub) {
      if (GroupPage.isUserManager) {
        if (sub.banned) {
          return PopupMenuButton<String>(
            onSelected: (String actionSelected) =>
                _popUpMenuActions(actionSelected, sub),
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
                _popUpMenuActions(actionSelected, sub),
            itemBuilder: (BuildContext context) => _popUpMenuItems,
          );
        }
      }

      return null;
    }

    Widget subIcon(Subscription sub) {
      if (sub.banned) {
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
            )
          ],
        );
      }

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

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        child: Icon(Icons.person),
      );
    }

    return Consumer<SubscriptionsProvider>(
      builder: (context, subscriptionsState, _) => CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (!subscriptionsState.subscriptions[index].banned &&
                    subscriptionsState.subscriptions[index].active) {
                  return ListTile(
                      leading: subIcon(subscriptionsState.subscriptions[index]),
                      title: Text(
                          subscriptionsState.subscriptions[index].student.name),
                      subtitle: Text(subscriptionsState
                          .subscriptions[index].student.email),
                      trailing: subscriptionAction(
                          subscriptionsState.subscriptions[index]));
                }

                return SizedBox(
                  height: 0,
                  width: 0,
                );
              },
              childCount: subscriptionsState.subscriptions.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (subscriptionsState.subscriptions[index].banned) {
                  return ListTile(
                      leading: subIcon(subscriptionsState.subscriptions[index]),
                      title: Text(
                        subscriptionsState.subscriptions[index].student.name,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      subtitle: Text(
                        subscriptionsState.subscriptions[index].student.email,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      trailing: subscriptionAction(
                          subscriptionsState.subscriptions[index]));
                }

                return SizedBox(
                  height: 0,
                  width: 0,
                );
              },
              childCount: subscriptionsState.subscriptions.length,
            ),
          ),
        ],
      ),
    );
  }
}
