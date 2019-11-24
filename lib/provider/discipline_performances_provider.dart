import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/model/user.dart';

class DisciplinePerformancesProvider with ChangeNotifier {
  List<Performance> _disciplinePerformances = List();

  get disciplinePerformances => _disciplinePerformances;

  void fetchPerformances(String disciplineId) async {
    var data = {
      'discipline_id': disciplineId.toString(),
      'user_id': Singleton().user.id.toString()
    };
    return PerformanceResource.list(data).then(handleResponse);
  }

  void handleResponse(dynamic response) {
    _disciplinePerformances = performanceFromJson(response.body);
    notifyListeners();
  }
}
