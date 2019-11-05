import 'package:flutter/material.dart';
import 'package:orion/api/resources/ban_resource.dart';
import 'package:orion/api/resources/manager_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/groups/subscription_icon.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/pages/group/group_page.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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

    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    //   child: Icon(Icons.person),
    // );

    return Consumer<SubscriptionsProvider>(
      builder: (context, subscriptionsState, _) => CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (!subscriptionsState.subscriptions[index].banned &&
                    subscriptionsState.subscriptions[index].active) {
                  return ListTile(
                      leading: SubscriptionIcon(
                          subscriptionsState.subscriptions[index]),
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
                      leading: SubscriptionIcon(
                          subscriptionsState.subscriptions[index]),
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
