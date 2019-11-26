import 'package:flutter/material.dart';
import 'package:orion/controllers/subscription_controller.dart';
import 'package:orion/model/group.dart';

class GroupInfoExit extends StatelessWidget {
  final Group group;

  GroupInfoExit(this.group);

  void _exitGroup(BuildContext context) async {
    SubscriptionController.removeFromGroup(context, group: group);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: ListTile(
      onTap: () => _exitGroup(context),
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
    ));
  }
}
