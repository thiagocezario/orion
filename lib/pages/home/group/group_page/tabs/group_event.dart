import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';
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

  Future _editEvent(Event event) async {
    Event result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return EventDialog(event);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      await Client.updateEvent(Singleton().jwtToken, result.id, result.title,
              result.content, DateTime.now().toString())
          .then((response) {
        Provider.of<GroupEventsProvider>(context)
            .fetchEvents(result.group.id.toString());
      });
    }
  }

  Future _createEvent() async {
    Event result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return EventDialog(null);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      await Client.createEvent(Singleton().jwtToken, group.id, result.id,
              result.title, result.content, DateTime.now().toString())
          .then((response) {
        Provider.of<GroupEventsProvider>(context)
            .fetchEvents(group.id.toString());
      });
    }
  }

  // TODO: Remover requisições desnecessarias
  Future _popUpMenuActions(String action, Event event) async {
    if (action == 'Editar') {
      await _editEvent(event);
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

    // Work with Sliver list, make it work!
    return Consumer<GroupEventsProvider>(
      builder: (context, groupEventsProvider, _) => Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: groupEventsProvider.groupEvents.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return OutlineButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Adicionar novo evento',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
                  onPressed: () async => await _createEvent(),
                );
              }
              return ListTile(
                leading: Icon(
                  Icons.access_time,
                  size: 25,
                ),
                title: Text(groupEventsProvider.groupEvents[index - 1].title),
                subtitle: Text(
                    groupEventsProvider.groupEvents[index - 1].description()),
                trailing:
                    eventActions(groupEventsProvider.groupEvents[index - 1]),
              );
            },
          ),
        ],
      ),
    );
  }
}
