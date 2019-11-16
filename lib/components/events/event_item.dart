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

class EventItem extends StatelessWidget {
  final Event _event;
  final Student currentStudent;
  final bool isPreview;
  Color _tileColor;

  EventItem(Key key, this._event, this.isPreview, {this.currentStudent})
      : super(key: key) {
    _tileColor = _event.student.id == Singleton().user.id
        ? Colors.grey.shade200
        : Colors.white;
  }

  void showEvent(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _tileColor,
      child: ListTile(
        onTap: () {
          if (!isPreview) {
            showEvent(context);
          }
        },
        leading: _LeadingEventDay(_event),
        trailing: Text(DateFormat('hh:mm').format(_event.date)),
        title: Text(_event.title),
        subtitle: Text(_event.content),
      ),
    );
  }
}

class _LeadingEventDay extends StatelessWidget {
  final Event _event;

  _LeadingEventDay(this._event);

  Color eventClor() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    if (format.parse(DateTime.now().toString()) ==
        format.parse(_event.date.toString())) {
      return Colors.green;
    }

    return _event.date.isBefore(DateTime.now()) ? Colors.grey : themeColor;
  }

  @override
  Widget build(BuildContext context) {
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
}
