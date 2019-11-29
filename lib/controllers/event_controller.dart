import 'package:flutter/cupertino.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/model/event.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:provider/provider.dart';

class EventController {
  GroupEventsProvider groupEventsProvider;
  MyEventsProvider myEventsProvider;

  setProviders(BuildContext context) {
    groupEventsProvider = Provider.of<GroupEventsProvider>(context);
    myEventsProvider = Provider.of<MyEventsProvider>(context);
  }

  refresh({group}) {
    groupEventsProvider.fetchEvents(group.id.toString());
    myEventsProvider.fetchEvents();
  }

  create(context, {Event event}) {
    setProviders(context);

    EventResource.createObject(event).then(
      (response) {
        refresh(group: event.group);
      },
    );
  }

  update(context, {Event event}) {
    setProviders(context);

    EventResource.updateObject(event).then(
      (response) {
        refresh(group: event.group);
      },
    );
  }

  remove(context, {Event event}) {
    setProviders(context);

    EventResource.delete(event.id.toString()).then(
      (response) {
        groupEventsProvider.removeEvent(event);
        myEventsProvider.removeEvent(event);
      },
    );
  }
}
