import 'package:flutter/material.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/pages/group/new_group_page.dart';

class FilterFloatingButton extends StatelessWidget {
  final Institution institution;
  final Course course;
  final Discipline discipline;

  FilterFloatingButton(this.institution, this.course, this.discipline);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 15.0,
      backgroundColor: themeColor,
      onPressed: () {
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewGroupPage(
                institution: institution,
                course: course,
                discipline: discipline,
              ),
            ),
          );
        }
      },
    );
  }
}
