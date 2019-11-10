import 'package:flutter/material.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/events/event_item.dart';
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

  _GroupEventState(this.group);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupEventsProvider>(
      builder: (context, groupEventsProvider, _) => Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: groupEventsProvider.groupEvents.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: CustomMaterialButton('Adicionar novo evento', () {
                      _createEvent();
                    }));
              }

              var event = groupEventsProvider.groupEvents[index - 1];

              return EventItem(key: UniqueKey(), event: event);
            },
          ),
        ],
      ),
    );
  }
}
