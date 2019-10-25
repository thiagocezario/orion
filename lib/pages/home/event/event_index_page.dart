import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:provider/provider.dart';

class EventIndexPage extends StatefulWidget {
  @override
  _EventIndexPageState createState() => _EventIndexPageState();
}

class _EventIndexPageState extends State<EventIndexPage> {
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
        Provider.of<MyEventsProvider>(context).fetchEvents();
      });
    }
  }

  // TODO: Remover requisições desnecessarias
  Future _popUpMenuActions(String action, Event event) async {
    if (action == 'Editar') {
      await _editEvent(event);
    } else if (action == 'Deletar') {
      await EventResource.delete(event.id.toString()).then((response) {
        Provider.of<MyEventsProvider>(context).fetchEvents();
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Consumer<MyEventsProvider>(
      builder: (context, myEventsProvider, _) => Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: myEventsProvider.myEvents.length,
            itemBuilder: (context, index) {
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
                          "${myEventsProvider.myEvents[index].date.day}",
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
                          DateFormat.MMMM()
                              .format(myEventsProvider.myEvents[index].date),
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(myEventsProvider.myEvents[index].title),
                subtitle: Text(myEventsProvider.myEvents[index].description()),
                trailing: eventActions(myEventsProvider.myEvents[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
