import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/model/event.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:provider/provider.dart';

class EventController {
  static refresh(context, {group}) {
    Provider.of<GroupEventsProvider>(context).fetchEvents(group.id.toString());
    Provider.of<MyEventsProvider>(context).fetchEvents();
  }

  static create(context, {Event event}) {
    EventResource.createObject(event).then(
      (response) {
        refresh(context, group: event.group);
      },
    );
  }

  static update(context, {Event event}) {
    EventResource.updateObject(event).then(
      (response) {
        refresh(context, group: event.group);
      },
    );
  }

  static remove(context, {Event event}) {
    EventResource.delete(event.id.toString()).then(
      (response) {
        Provider.of<GroupEventsProvider>(context).removeEvent(event);
        Provider.of<MyEventsProvider>(context).removeEvent(event);
      },
    );
  }
}
