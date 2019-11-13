import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/student.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  final Event event;
  final Student currentStudent;

  EventItem({Key key, this.event, this.currentStudent}) : super(key: key);

  @override
  _EventItemState createState() => _EventItemState(event);
}

class _EventItemState extends State<EventItem> {
  Event _event;
  Color _tileColor;

  _EventItemState(Event event) {
    this._event = event;
    _tileColor = _event.student.id == Singleton().user.id ? Colors.grey.shade200 : Colors.white;
  }

  Color eventClor() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    if(format.parse(DateTime.now().toString()) == format.parse(_event.date.toString())) {
      return Colors.green;
    }

    return _event.date.isBefore(DateTime.now()) ? Colors.grey : themeColor;
  }

  void showEvent() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) {
        return EventDialog(_event);
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
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(_event.date.toString());

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
                color: eventClor(),
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
      color: _tileColor,
      child: ListTile(
        onTap: showEvent,
        leading: dayLeading(),
        trailing: Text(DateFormat('hh:mm').format(_event.date)),
        title: Text(_event.title),
        subtitle: Text(_event.content),
      ),
    );
  }
}
