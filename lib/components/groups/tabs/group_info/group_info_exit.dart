import 'package:flutter/material.dart';
import 'package:orion/controllers/group_controller.dart';
import 'package:orion/controllers/subscription_controller.dart';
import 'package:orion/model/group.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class GroupInfoExit extends StatelessWidget {
  final Group group;

  GroupInfoExit(this.group);

  void _exitGroup(BuildContext context) async {
    bool isExiting = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Você tem certeza que deseja sair do grupo?"),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCELAR"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text("SAIR"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (isExiting) {
      await SubscriptionController.removeFromGroup(context, group: group);
      Provider.of<MyGroupsProvider>(context).refreshMyGroups();
      Provider.of<GroupRecomendationsProvider>(context)
          .refreshMyRecomendations();
      Provider.of<MyEventsProvider>(context).fetchEvents();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
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
