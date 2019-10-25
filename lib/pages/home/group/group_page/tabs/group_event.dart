import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
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
      await EventResource.updateObject(result).then((response) {
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
      result.student = Singleton().user;
      result.group = group;
      await EventResource.createObject(result).then((response) {
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
      await EventResource.delete(event.id.toString()).then((response) {
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
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: primaryButtonColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      elevation: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Adicionar novo evento',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () async => await _createEvent(),
                    ),
                  ),
                );
              }
              return ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 25,
                      height: 25,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${groupEventsProvider.groupEvents[index - 1].date.day}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          DateFormat.MMMM().format(
                              groupEventsProvider.groupEvents[index - 1].date),
                        ),
                      ),
                    ),
                  ],
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
