import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/events/event_cards.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';

class GroupEvent extends StatefulWidget {
  final Group group;

  GroupEvent(this.group);

  @override
  _GroupEventState createState() => _GroupEventState(group, true);
}

class _GroupEventState extends State<GroupEvent> {
  List<Event> _events = List();
  ListView _cardsList = ListView();
  final Group group;
  bool shouldRefresh = true;

  _GroupEventState(this.group, this.shouldRefresh);

  void listGroups() async {
    await Client.listEvents(Singleton().jwtToken, group.id.toString(), Singleton().user.id)
        .then((response) {
          setState(() {
            String jsonResponse = response.body;
            print(jsonResponse);
            _events = eventFromJson(jsonResponse);
            print(eventFromJson);
            _cardsList = EventCards().getEventCards(context, _events);
            shouldRefresh = false;
          });
        });

    // setState(() {
    //   Event event = Event(id: 1, title: "title", content: "content");
    //   Event event2 = Event(id: 2, title: "title 2", content: "content 2");
    //   _events.add(event);
    //   _events.add(event2);

    //   _cardsList = EventCards().getEventCards(context, _events);
    // });
  }

  @override
  Widget build(BuildContext context) {
    if(shouldRefresh){
      listGroups();
    }

    return Container(
      alignment: Alignment.center,
      child: _cardsList,
    );
  }
}
