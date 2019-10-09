import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/model/user.dart';

class DisciplinePerformancesProvider with ChangeNotifier {
  List<Performance> _disciplinePerformances = List();

  get disciplinePerformances => _disciplinePerformances;

  void fetchPerformances(String disciplineId) async {
    await Client.listPerformances(Singleton().jwtToken, disciplineId, Singleton().user.id).then((response) {
      print(response.body);

      _disciplinePerformances = performanceFromJson(response.body);
      notifyListeners();
    });
  }
}