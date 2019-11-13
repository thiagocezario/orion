import 'package:flutter/material.dart';
import 'package:orion/api/resources/course_resource.dart';
import 'package:orion/api/resources/discipline_resource.dart';
import 'package:orion/api/resources/institution_resource.dart';
import 'package:orion/model/course.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/institution.dart';

class SearchGroupsProvider extends ChangeNotifier {
  List<Institution> _institutions = List();
  List<Course> _courses = List();
  List<Discipline> _disciplines = List();

  get institutions => _institutions;
  get courses => _courses;
  get disciplines => _disciplines;

  void refreshItems() async {
    // TODO: Remover
    InstitutionResource.list(null).then(handleInstitutionResponse);
    CourseResource.list(null).then(handleCourseResponse);
    DisciplineResource.list(null).then(handleDisciplineResponse);
  }

  void refreshInstitutions() async {
    InstitutionResource.list(null).then(handleInstitutionResponse);
  }

  void refreshCourses(int institutionId) async {
    var data = {"institution_id": institutionId.toString()};
    CourseResource.list(data).then(handleCourseResponse);
  }

  void refreshDisciplines(int courseId) async {
    var data = {"course_id": courseId.toString()};
    DisciplineResource.list(data).then(handleDisciplineResponse);
  }

  void handleInstitutionResponse(dynamic response) {
    _institutions = institutionFromJson(response.body);
    notifyListeners();
  }

  void handleCourseResponse(dynamic response) {
    _courses = courseFromJson(response.body);
    notifyListeners();
  }

  void handleDisciplineResponse(dynamic response) {
    _disciplines = disciplineFromJson(response.body);
    notifyListeners();
  }
}
