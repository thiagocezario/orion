import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/model/event.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  final Event event;

  EventItem({Key key, this.event}) : super(key: key);

  @override
  _EventItemState createState() => _EventItemState(event);
}

class _EventItemState extends State<EventItem> {
  Event event;

  _EventItemState(this.event);

  void showEvent() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) {
        return EventDialog(event);
      },
      fullscreenDialog: true,
    ))
        .then((result) {
      if (result != null) {
        EventResource.updateObject(result).then((response) {
          Provider.of<MyEventsProvider>(context).fetchEvents();
        });
      }
    });
  }

  Column dayLeading() {
    DateTime date =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(event.date.toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 35,
          height: 25,
          child: Align(
            alignment: Alignment.topCenter,
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
              DateFormat.MMM().format(date),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: showEvent,
        leading: dayLeading(),
        trailing: Text(DateFormat('hh:mm').format(event.date)),
        title: Text(event.title),
        subtitle: Text(event.content),
      ),
    );
  }
}
