import 'package:orion/model/institution.dart';

import '../base.dart';

class InstitutionResource {
  static String path() {
    return '/api/institutions';
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

  static Future createObject(Institution institution) async {
    var data = {"name": institution.name};
    return create(data);
  }

  static Future updateObject(Institution institution) async {
    var data = {"name": institution.name};
    return update(institution.id.toString(), data);
  }
}
