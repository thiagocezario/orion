import 'package:flutter/widgets.dart';
import 'package:orion/components/events/event_cards.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:provider/provider.dart';

class EventIndexPage extends StatefulWidget {
  @override
  _EventIndexPageState createState() => _EventIndexPageState();
}

class _EventIndexPageState extends State<EventIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyEventsProvider>(
      builder: (context, myEventsProvider, _) => Container(
        alignment: Alignment.center,
        child: EventCards().getEventCards(context, myEventsProvider.myEvents),
      ),
    );
  }
}
