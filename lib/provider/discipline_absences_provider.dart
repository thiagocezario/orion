import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/absence_resource.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/model/user.dart';

class DisciplineAbsencesProvider with ChangeNotifier {
  List<Absence> _disciplineAbsences = List();

  get disciplineAbsences => _disciplineAbsences;

  void fetchAbsences(String disciplineId) async {
    var data = {
      'discipline_id': disciplineId.toString(),
      'user_id': Singleton().user.id.toString()
    };

    return AbsenceResource.list(data).then(handleResponse);
  }

  void handleResponse(dynamic response) {
    _disciplineAbsences = absenceFromJson(response.body);
    notifyListeners();
  }
}
