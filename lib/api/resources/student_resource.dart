import 'package:orion/model/user.dart';

import '../base.dart';

class GroupResource {
  static String path() {
    return '/api/students';
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

  static Future createObject(User student) async {
    var data = {
      'name': student.name,
      'email': student.email,
      'password': student.password
    };

    return create(data);
  }

  static Future updateObject(User student) async {
    var data = {
      'name': student.name,
      'email': student.email,
      'password': student.password
    };
    return update(student.id.toString(), data);
  }
}
