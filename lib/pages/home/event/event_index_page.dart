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
  Future _showEvent(Event event) async {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<MyEventsProvider>(
      builder: (context, myEventsProvider, _) => Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: myEventsProvider.myEvents.length,
            itemBuilder: (context, index) {

              var event = myEventsProvider.myEvents[index];
              DateTime date = DateFormat("yyyy-MM-dd hh:mm:ss")
                  .parse(event.date.toString());

              return ListTile(
                onTap: () async => await _showEvent(event),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 25,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${date.day}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 25,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          DateFormat.MMM()
                              .format(date),
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(myEventsProvider.myEvents[index].title),
                subtitle: Text(myEventsProvider.myEvents[index].content),
              );
            },
          ),
        ],
      ),
    );
  }
}
