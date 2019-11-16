import 'package:flutter/material.dart';
import 'package:orion/components/events/event_item.dart';
import 'package:orion/model/event.dart';

class GroupEventsPreview extends StatelessWidget {
  final List<Event> events;

  GroupEventsPreview(this.events);

  @override
  Widget build(BuildContext context) {
    if (events.length == 0) {
      return SliverToBoxAdapter(
        child: ListTile(
          title: Text(
            'Não existem eventos cadastrados neste grupo.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
            ),
          ),
          enabled: false,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: <Widget>[
              EventItem(UniqueKey(), events[index], true),
            ],
          );
        },
        childCount: events.length > 3 ? 3 : events.length,
      ),
    );
  }
}
