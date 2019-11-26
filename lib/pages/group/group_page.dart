import 'package:flutter/material.dart';
import 'package:orion/controllers/event_controller.dart';
import 'package:orion/controllers/post_controller.dart';
import 'package:orion/components/events/evet_dialog.dart';
import 'package:orion/components/groups/tabs/group_personal_performance.dart';
import 'package:orion/components/posts/post_dialog.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/components/groups/tabs/group_event.dart';
import 'package:orion/components/groups/tabs/group_post.dart';
import 'package:orion/model/post.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/group/group_info_page.dart';
import 'package:page_transition/page_transition.dart';

class GroupPage extends StatefulWidget {
  final group;

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
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabChange);
    _fabButton = _bottomButtons();
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
      length: 3,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  GroupPost(group),
                  GroupEvent(group),
                  PersonalPerformance(group.discipline, group),
                ],
              ),
            ),
            Container(
              height: 90,
              padding: EdgeInsets.only(top: 28, left: 20, right: 20),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: _GroupName(group),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: darkGreyColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: darkGreyColor,
            labelPadding: EdgeInsets.all(0),
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
            ],
          ),
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
          backgroundColor: themeColor,
          child: Icon(
            Icons.add,
            size: 20.0,
          ),
        );
      case 1:
        return FloatingActionButton(
          heroTag: "eventFAB",
          onPressed: () => _createEvent(),
          backgroundColor: themeColor,
          child: Icon(
            Icons.add,
            size: 20.0,
          ),
        );
      default:
        return null;
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

      PostController.create(context, post: result);
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
      EventController.create(context, event: result);
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

  final Group group;

  _GroupNameState(this.group) {
    _nameTextController.text = group.name;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        group.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Avenir',
        ),
      ),
      onTap: eita,
    );
  }

  void eita() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.upToDown,
        child: Material(
          child: GroupInfoPage(group),
        ),
      ),
    );
  }
}
