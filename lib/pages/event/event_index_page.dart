import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/event.dart';
import 'package:orion/components/events/event_cards.dart';
import 'package:orion/model/user.dart';

class EventIndexPage extends StatefulWidget {
  @override
  _EventIndexPageState createState() => _EventIndexPageState(true);
}

class _EventIndexPageState extends State<EventIndexPage> {
  List<Event> _events = List();
  ListView _cardsList = ListView();
  bool shouldRefresh = true;

  _EventIndexPageState(bool shouldRefresh) {
    this.shouldRefresh = shouldRefresh;
  }

  void listGroups() async {
    await Client.listEvents(Singleton().jwtToken, "", Singleton().user.id)
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
