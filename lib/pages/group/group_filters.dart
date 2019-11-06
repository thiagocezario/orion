import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/group/group_preview_page.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

import 'new_group_page.dart';

class NewGroupFilter extends StatefulWidget {
  final int institutionId;
  final int courseId;
  final int disciplineId;

  NewGroupFilter(
      {Key key, this.institutionId, this.courseId, this.disciplineId})
      : super(key: key);

  @override
  _NewGroupFilterState createState() =>
      _NewGroupFilterState(institutionId, courseId, disciplineId);
}

class _NewGroupFilterState extends State<NewGroupFilter> {
  int institutionId;
  int courseId;
  int disciplineId;

  Widget _groupCards;

  _NewGroupFilterState(int institutionId, int courseId, int disciplineId) {
    this.institutionId = institutionId;
    this.courseId = courseId;
    this.disciplineId = disciplineId;

    _listGroups();
  }

  void _listGroups() async {
    var data = {
      "institution_id": institutionId.toString(),
      "course_id": courseId.toString(),
      "discipline_id": disciplineId.toString()
    };

    GroupResource.list(data).then((response) {
      List<Group> groups = groupFromJson(response.body);
      _buildList(groups);
    });
  }

  void _buildList(List<Group> groups) {
    setState(() {
      _groupCards = ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Material(
            child: InkWell(
              onTap: () {
                Provider.of<GroupPostsProvider>(context)
                    .fetchPosts(groups[index].id.toString());
                Provider.of<SubscriptionsProvider>(context)
                    .fetchSubscriptions(groups[index].id.toString());
                Provider.of<GroupEventsProvider>(context)
                    .fetchEvents(groups[index].id.toString());

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupPreviewPage(groups[index])));
              },
              child: GroupCard(groups[index]),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8893f2),
          elevation: 0.0,
          title: Text(
            'Grupos',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () => _listGroups(),
            ),
          ],
        ),
        body: _groupCards,
        floatingActionButton: _buildFloatingButton(context));
  }

  Widget _buildFloatingButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 15.0,
          backgroundColor: Colors.green,
          onPressed: () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color(0xff8893f2),
                      elevation: 0.0,
                      title: Text(
                        'Novo Grupo',
                        style: TextStyle(color: Colors.black),
                      ),
                      centerTitle: true,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    body: NewGroupPage(),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
