import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/components/groups/filter_fab.dart';
import 'package:orion/components/groups/group_item.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/pages/group/group_preview_page.dart';
import 'package:orion/provider/preview_provider.dart';
import 'package:provider/provider.dart';

class NewGroupFilter extends StatefulWidget {
  final Institution institution;
  final Course course;
  final Discipline discipline;

  NewGroupFilter({Key key, this.institution, this.course, this.discipline})
      : super(key: key);

  @override
  _NewGroupFilterState createState() =>
      _NewGroupFilterState(institution, course, discipline);
}

class _NewGroupFilterState extends State<NewGroupFilter> {
  Institution institution;
  Course course;
  Discipline discipline;

  Widget _groupCards;

  _NewGroupFilterState(this.institution, this.course, this.discipline) {
    _listGroups();
  }

  void _listGroups() async {
    Map<String, String> data = {
      "institution_id": (institution.id ?? '').toString(),
      "course_id": (course.id ?? '').toString(),
      "discipline_id": (discipline.id ?? '').toString(),
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
      floatingActionButton:
          FilterFloatingButton(institution, course, discipline),
    );
  }
}
