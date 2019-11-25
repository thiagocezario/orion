import 'package:flutter/material.dart';
import 'package:orion/components/events/event_item.dart';
import 'package:orion/components/groups/tabs/tab_title.dart';
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

  Widget eventsList(GroupEventsProvider groupEventsProvider) {
    int length = groupEventsProvider.groupEvents.length;
    if (length == 0) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          child: Text(
            'Este grupo ainda não possui eventos registrados!',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            key: UniqueKey(),
            children: <Widget>[
              EventItem(
                  UniqueKey(), groupEventsProvider.groupEvents[index], false),
              Divider(
                height: 5,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
            ],
          );
        },
        childCount: groupEventsProvider.groupEvents.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupEventsProvider>(
      builder: (context, groupEventsProvider, _) => CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TabTitle(title: 'Eventos'),
          ),
          eventsList(groupEventsProvider),
        ],
      ),
    );
  }
}
