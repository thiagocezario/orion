import 'package:orion/model/absence.dart';

import '../base.dart';

class AbsenceResource {
  static String path() {
    return '/api/absences';
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

  static Future createObject(Absence absence) async {
    var data = {
      "discipline_id": absence.discipline.id.toString(),
      "quantity": absence.quantity.toString(),
      "date": absence.date.toString(),
      "year": absence.year.toString()
    };
    return create(data);
  }

  static Future updateObject(Absence absence) async {
    var data = {
      "quantity": absence.quantity.toString(),
      "date": absence.date.toIso8601String(),
      "year": absence.year.toString()
    };
    return update(absence.id.toString(), data);
  }
}
