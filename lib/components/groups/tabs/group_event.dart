import 'package:flutter/material.dart';
import 'package:orion/components/events/event_item.dart';
import 'package:orion/model/group.dart';
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

  _GroupEventState(this.group);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupEventsProvider>(
      builder: (context, groupEventsProvider, _) => Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: groupEventsProvider.groupEvents.length,
            itemBuilder: (context, index) {
              var event = groupEventsProvider.groupEvents[index];

              return EventItem(UniqueKey(), event, false);
            },
          ),
        ],
      ),
    );
  }
}
