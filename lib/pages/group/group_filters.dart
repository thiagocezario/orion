import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/components/groups/filter_fab.dart';
import 'package:orion/controllers/group_controller.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/pages/group/group_preview_page.dart';
import 'package:orion/provider/preview_provider.dart';
import 'package:provider/provider.dart';

class NewGroupFilter extends StatefulWidget {
  final Group group;

  NewGroupFilter({Key key, this.group}) : super(key: key);

  @override
  _NewGroupFilterState createState() => _NewGroupFilterState(group);
}

class _NewGroupFilterState extends State<NewGroupFilter> {
  Group group;
  List<Group> groups;
  List<Group> myGroups;
  List<Group> newGroups;

  _NewGroupFilterState(this.group) {
    groups = List<Group>();
    myGroups = List<Group>();
    newGroups = List<Group>();
    _listGroups();
  }

  void _listGroups() async {
    Map<String, String> data = {
      "institution_id": (group.institution.id ?? '').toString(),
      "course_id": (group.course.id ?? '').toString(),
      "discipline_id": (group.discipline.id ?? '').toString(),
      "year": (group.year ?? ''),
    };

    GroupResource.list(data).then((response) {
      setState(() {
        groups = groupFromJson(response.body);
        myGroups =
            groups.where((Group group) => doideta(context, group)).toList();
        newGroups =
            groups.where((Group group) => !doideta(context, group)).toList();
      });
    });
  }

  bool doideta(BuildContext context, Group group) {
    Subscription subscription =
        GroupController.mySubscription(context, group: group);
    return subscription != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0.0,
        title: Text(
          'Grupos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            // color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              Group group = newGroups[index];

              return ListTile(
                onTap: () {
                  Provider.of<PreviewProvider>(context)
                      .refreshAll(groups[index]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupPreviewPage(groups[index]),
                    ),
                  );
                },
                title: Text(group.name),
                subtitle: Text(group.discipline.name),
                trailing: Column(
                  children: <Widget>[
                    Icon(Icons.person_add, color: themeColor),
                    Text(group.metadata.subscriptions.toString()),
                  ],
                ),
              );
            }, childCount: newGroups.length),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              Group group = myGroups[index];
              return ListTile(
                enabled: false,
                title: Text(group.name),
                subtitle: Text(group.discipline.name),
              );
            }, childCount: myGroups.length),
          ),
        ],
      ),
      floatingActionButton: FilterFloatingButton(group),
    );
  }
}
