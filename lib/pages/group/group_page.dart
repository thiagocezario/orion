import 'package:flutter/material.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/components/performances/performance_dialog.dart';
import 'package:orion/components/posts/post_dialog.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/group.dart';
import 'package:orion/components/groups/tabs/discipline_performance.dart';
import 'package:orion/components/groups/tabs/group_event.dart';
import 'package:orion/components/groups/tabs/group_info.dart';
import 'package:orion/components/groups/tabs/group_post.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/model/post.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  final group;
  static bool isUserManager = false;

  GroupPage(this.group);

  @override
  _GroupPageState createState() => _GroupPageState(group);
}

class _GroupPageState extends State<GroupPage> with SingleTickerProviderStateMixin {
  Group group;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _GroupPageState(this.group) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8893f2),
          title: Text(group.name),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.event_note),
              ),
              Tab(
                icon: Icon(Icons.equalizer),
              ),
              Tab(
                icon: Icon(Icons.info),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            GroupPost(group),
            GroupEvent(group),
            DisciplinePerformance(group.discipline, group),
            GroupInfo(group),
          ],
        ),
        floatingActionButton: _bottomButtons(),
      ),
    );
  }

  Widget _bottomButtons() {
    switch (_tabController.index) {
      case 0:
        return FloatingActionButton(
            onPressed: () => _createPost(),
            backgroundColor: Colors.greenAccent,
            child: Icon(
              Icons.add,
              size: 20.0,
            ));
      case 1:
        return FloatingActionButton(
            onPressed: () => _createEvent(),
            backgroundColor: Colors.greenAccent,
            child: Icon(
              Icons.add,
              size: 20.0,
            ));
      case 2:
        return FloatingActionButton(
            onPressed: () => _createPerformance(),
            backgroundColor: Colors.greenAccent,
            child: Icon(
              Icons.add,
              size: 20.0,
            ));
      default:
        return null;
    }
  }

  Future _createPerformance() async {
    Performance result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PerformanceDialog(null);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      result.discipline = group.discipline;

      await PerformanceResource.createObject(result).then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }

  Future _createPost() async {
    Post result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return GroupPostDialog(null, group);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      result.group = group;
      result.student = Singleton().user;

      await PostResource.createObject(result).then((response) {
        Provider.of<GroupPostsProvider>(context)
            .fetchPosts(group.id.toString());
      });
    }
  }

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
}
