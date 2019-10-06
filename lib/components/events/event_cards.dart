import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/model/event.dart';

class EventCards {
  ListView getEventCards(BuildContext context, List<Event> events) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(events[index]);
      },
    );
  }

  Widget _buildEventCard(Event event) {
    IconButton eventActions(Event event) {
      if (event.student.id == 2) {
        return IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        );
      }

      return null;
    }

    ListTile card = ListTile(
      leading: Container(
        child: Icon(
          Icons.access_time,
          size: 25,
        ),
      ),
      title: Text(event.title),
      subtitle: Text(event.description()),
      trailing: eventActions(event),
      isThreeLine: true,
    );

    return Material(
      child: InkWell(
        onTap: () {},
        child: card,
      ),
    );
  }
}
