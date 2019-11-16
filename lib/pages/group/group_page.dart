import 'package:flutter/material.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
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
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  final group;
  static bool isUserManager = false;

  GroupPage(this.group);

  @override
  _GroupPageState createState() => _GroupPageState(group);
}

class _GroupPageState extends State<GroupPage>
    with SingleTickerProviderStateMixin {
  Group group;
  TabController _tabController;
  Widget _fabButton;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      _fabButton = _bottomButtons();
    });
  }

  _GroupPageState(this.group);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8893f2),
          title: _GroupName(group),
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
        floatingActionButton: _fabButton,
      ),
    );
  }

  Widget _bottomButtons() {
    switch (_tabController.index) {
      case 0:
        return FloatingActionButton(
            heroTag: "postFAB",
            onPressed: () => _createPost(),
            backgroundColor: Colors.greenAccent,
            child: Icon(
              Icons.add,
              size: 20.0,
            ));
      case 1:
        return FloatingActionButton(
            heroTag: "eventFAB",
            onPressed: () => _createEvent(),
            backgroundColor: Colors.greenAccent,
            child: Icon(
              Icons.add,
              size: 20.0,
            ));
      case 2:
        return FloatingActionButton(
            heroTag: "scoreFAB",
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

class _GroupName extends StatefulWidget {
  final Group group;

  _GroupName(this.group);

  @override
  _GroupNameState createState() => _GroupNameState(group);
}

class _GroupNameState extends State<_GroupName> {
  final TextEditingController _nameTextController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();

  final Group group;

  _GroupNameState(this.group) {
    _nameTextController.text = group.name;
  }

  @override
  Widget build(BuildContext context) {
    return EditableText(
      onSubmitted: (value) {
        _editGroupName(value);
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      backgroundCursorColor: Colors.black,
      textAlign: TextAlign.justify,
      controller: _nameTextController,
      cursorColor: Colors.white,
      focusNode: _descriptionFocusNode,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Future<void> _editGroupName(String name) async {
    group.name = name;
    await GroupResource.updateObject(group);
    Provider.of<MyGroupsProvider>(context).refreshMyGroups();
  }
}
