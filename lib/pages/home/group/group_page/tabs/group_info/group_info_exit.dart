import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class GroupInfoExit extends StatelessWidget {
  final Group group;

  GroupInfoExit(this.group);

  void _exitGroup(BuildContext context) async {
    var data = {
      'group_id': group.id.toString(),
      'user_id': Singleton().user.id.toString()
    };
    await SubscriptionResource.list(data).then((response) async {
      var result = subscriptionFromJson(response.body);
      await Client.unsubscribe(Singleton().jwtToken, result.first.id)
          .then((response) {
        Provider.of<MyGroupsProvider>(context).refreshMyGroups();
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () => _exitGroup(context),
        child: ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: Text(
            'Deixar grupo',
            style: TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
