import 'package:flutter/material.dart';
import 'package:orion/components/groups/search/course/course_tile.dart';
import 'package:orion/model/course.dart';

class CourseSearch extends SearchDelegate<Course> {
  final List<Course> courses;
  List<Course> lastUsed;

  CourseSearch(this.courses) {
    lastUsed = courses;
  }

  List<Course> _filterCourse(
      String query, List<Course> courses) {
    List<Course> filteredCourses = List();

    if (query == '') return courses;

    for (var course in courses) {
      if (course.name.toLowerCase().contains(query.toLowerCase())) {
        filteredCourses.add(course);
      }
    }

    return filteredCourses;
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
        onPressed: () => {},
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
    List<Course> filteredCourses =
        _filterCourse(query, courses);
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