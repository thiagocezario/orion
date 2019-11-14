import 'package:orion/model/event.dart';

import '../base.dart';

class EventResource {
  static String path() {
    return '/api/events';
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

  static Future createObject(Event event) async {
    var data = {
      "group_id": event.group.id.toString(),
      "user_id": event.student.id.toString(),
      "title": event.title,
      "content": event.content,
      "date": event.date.toIso8601String()
    };
    return create(data);
  }

  static Future updateObject(Event event) async {
    var data = {
      "title": event.title,
      "content": event.content,
      "date": event.date.toIso8601String()
    };
    return update(event.id.toString(), data);
  }
}
