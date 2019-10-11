import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/home/group/group_page/group_page.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:provider/provider.dart';

class GroupEvent extends StatefulWidget {
  final Group group;

  GroupEvent(this.group);

  @override
  _GroupEventState createState() => _GroupEventState(group);
}

class _GroupEventState extends State<GroupEvent> {
  final Group group;
  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Editar', 'Deletar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();


  // TODO: Remover requisições desnecessarias
  Future _popUpMenuActions(String action, Event event) async {
    if (action == 'Editar') {
      await Client.updateEvent(Singleton().jwtToken, event.id, event.title, event.content, DateTime.now().toString()).then((response) {
        Provider.of<GroupEventsProvider>(context)
            .fetchEvents(group.id.toString());
      });
    } else if (action == 'Deletar') {
      await Client.deleteEvent(Singleton().jwtToken, event.id).then((response) {
        Provider.of<GroupEventsProvider>(context)
            .fetchEvents(group.id.toString());
      });
    }
  }

  _GroupEventState(this.group);

  @override
  Widget build(BuildContext context) {
    PopupMenuButton<String> eventActions(Event event) {
      if (event.student.id == Singleton().user.id) {
        return PopupMenuButton<String>(
          onSelected: (String actionSelected) =>
              _popUpMenuActions(actionSelected, event),
          itemBuilder: (BuildContext context) => _popUpMenuItems,
        );
      }

      return null;
    }

    return Consumer<GroupEventsProvider>(
      builder: (context, groupEventsProvider, _) => Container(
        child: ListView.builder(
          itemCount: groupEventsProvider.groupEvents.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.access_time, size: 25,),
              title: Text(groupEventsProvider.groupEvents[index].title),
              subtitle: Text(groupEventsProvider.groupEvents[index].description()),
              trailing: eventActions(groupEventsProvider.groupEvents[index]),
            );
          },
        )
      ),
    );
  }
}
