import 'package:orion/model/group.dart';

import '../base.dart';

class GroupResource {
  static String path() {
    return '/api/groups';
  }

  static Future find(String resourceId) async {
    return Base.findResource(path(), resourceId);
  }

  static Future list(dynamic data) async {
    return Base.listResources(path(), data..addAll({'exclude_privates': 'true'}));
  }

  static Future listAll(dynamic data) async {
    return Base.listResources(path(), data);
  }

  static Future create(dynamic data) async {
    return Base.createResource(path(), data);
  }

  static Future update(String resourceId, dynamic data) async {
    return Base.updateResource(path(), resourceId, data);
  }

  static Future delete(String resourceId) async {
    return Base.deleteResource(path(), resourceId);
  }

  static Future createObject(Group group) async {
    var data = {
      "name": group.name,
      "description": group.description,
      "private": false,
      "institution_id": group.institution.id,
      "course_id": group.course.id,
      "discipline_id": group.discipline.id,
    };

    return create(data);
  }

  static Future updateObject(Group group) async {
    var data = {
      "name": group.name,
      "description": group.description,
      "private": false
    };
    return update(group.id.toString(), data);
  }

  static Future listRecomendations(dynamic data) async {
    String recomendationsPath = '${path()}/recomendations';
    return Base.listResources(recomendationsPath, data);
  }
}
