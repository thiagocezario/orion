import 'package:orion/model/performance.dart';

import '../base.dart';

class PerformanceResource {
  static String path() {
    return '/api/performances';
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

  static Future createObject(Performance performance, String year) async {
    var data = {
      "discipline_id": performance.discipline.id.toString(),
      "description": performance.description,
      "value": performance.value.toString(),
      "max_value": performance.maxValue.toString(),
      "year": year,
    };
    return create(data);
  }

  static Future updateObject(Performance performance) async {
    var data = {
      "description": performance.description,
      "value": performance.value.toString(),
      "max_value": performance.maxValue.toString()
    };
    return update(performance.id.toString(), data);
  }
}
