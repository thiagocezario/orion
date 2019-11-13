import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orion/api/resources/course_resource.dart';
import 'package:orion/components/groups/search/course/course_tile.dart';
import 'package:orion/components/groups/search/create_dialog.dart';
import 'package:orion/main.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/institution.dart';
import 'package:orion/provider/search_groups_provider.dart';
import 'package:provider/provider.dart';

class CourseSearch extends SearchDelegate<Course> {
  final Institution selectedInstitution;
  final List<Course> courses;
  List<Course> lastUsed;

  CourseSearch(this.courses, this.selectedInstitution) {
    lastUsed = courses;
  }

  List<Course> _filterCourse(String query, List<Course> courses) {
    List<Course> filteredCourses = List();

    if (query == '') return courses;

    for (var course in courses) {
      if (course.name.toLowerCase().contains(query.toLowerCase())) {
        filteredCourses.add(course);
      }
    }

    return filteredCourses;
  }

  void _addNewCourse(BuildContext context) async {
    String result = await showDialog(
      context: context,
      child: CreateDialog('Curso'),
    );

    if (result != null && result.length > 3) {
      var data = {"name": result, "institution_id": selectedInstitution.id};
      CourseResource.create(data).then(
        (response) {
          if (response.statusCode == 201) {
            var json = jsonDecode(response.body);
            Course course = Course.fromJson(json);
            courses.add(course);
            Provider.of<SearchGroupsProvider>(context).refreshItems();
          } else if (response.statusCode == 401) {
            showDialog(
              context: context,
              child: AlertDialog(
                title: Text('Erro'),
                content: Text("Sua sessão expirou. Por favor entre novamente."),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () =>
                        Navigator.of(context).popAndPushNamed(LoginPageRoute),
                  ),
                ],
              ),
            );
          } else {
            showDialog(
              context: context,
              child: AlertDialog(
                title: Text('Erro'),
                content: Text("Ocorreu um erro inesperado. Por favor, tente novamente."),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () =>
                        Navigator.of(context).pop(),
                  ),
                ],
              ),
            );
          }
        },
      ).catchError(
        (error) {
          showDialog(
            context: context,
            child: AlertDialog(
              title: Text('Erro'),
              content: Text("Ocorreu um erro inesperado. Por favor, tente novamente."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _addNewCourse(context),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Course> filteredCourses = _filterCourse(query, courses);
    lastUsed = filteredCourses;

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return CourseTile(filteredCourses[index]);
      },
      itemCount: filteredCourses.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CourseTile(lastUsed[index]);
      },
      itemCount: lastUsed.length,
    );
  }
}
