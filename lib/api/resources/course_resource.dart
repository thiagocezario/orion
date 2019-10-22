import 'package:orion/model/course.dart';

import '../base.dart';

class CourseResource {
  static String path() {
    return '/api/courses';
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

  static Future createObject(Course course) async {
    var data = {"name": course.name};
    return create(data);
  }

  static Future updateObject(Course course) async {
    var data = {"name": course.name};
    return update(course.id.toString(), data);
  }
}
