import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/components/groups/filter_fab.dart';
import 'package:orion/components/groups/group_item.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
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

  Widget _groupCards;

  _NewGroupFilterState(this.group) {
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
      List<Group> groups = groupFromJson(response.body);
      _buildList(groups);
    });
  }

  void _buildList(List<Group> groups) {
    setState(() {
      _groupCards = ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Material(
            child: InkWell(
              onTap: () {
                Provider.of<PreviewProvider>(context).refreshAll(groups[index]);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupPreviewPage(groups[index])));
              },
              child: GroupCard(group: groups[index]),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
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
      ),
      body: _groupCards,
      floatingActionButton: FilterFloatingButton(group),
    );
  }
}
