import 'package:orion/model/discipline.dart';

import '../base.dart';

class DisciplineResource {
  static String path() {
    return '/api/disciplines';
  }

  static Future list(dynamic data) async {
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

  static Future createObject(Discipline discipline) async {
    var data = {"name": discipline.name};
    return create(data);
  }

  static Future updateObject(Discipline discipline) async {
    var data = {"name": discipline.name};
    return update(discipline.id.toString(), data);
  }
}
