import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/events/event_item.dart';
import 'package:orion/model/event.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyEventsProvider>(
      builder: (context, myEventsProvider, _) => ListView.separated(
        padding: EdgeInsets.all(5),
        separatorBuilder: (context, index) {
          return Divider(
            indent: 5,
            endIndent: 5,
          );
        },
        physics: BouncingScrollPhysics(),
        itemCount: myEventsProvider.myEvents.length,
        itemBuilder: (context, index) {
          Event event = myEventsProvider.myEvents[index];
          return EventItem(UniqueKey(), event, false);
        },
      ),
    );
  }
}
