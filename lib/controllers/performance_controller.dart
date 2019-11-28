import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:provider/provider.dart';

class PerformanceController {
  static refresh(context, {discipline, year}) {
    Provider.of<DisciplinePerformancesProvider>(context).fetchPerformances(discipline.id.toString(), year);
  }

  static create(context, {Performance performance, String year}) {
    PerformanceResource.createObject(performance, year).then(
      (response) {
        refresh(context, discipline: performance.discipline);
      },
    );
  }

  static update(context, {Performance performance}) {
    PerformanceResource.updateObject(performance).then(
      (response) {
        refresh(context, discipline: performance.discipline);
      },
    );
  }

  static remove(context, {Performance performance}) {
    PerformanceResource.delete(performance.id.toString()).then(
      (response) {
        Provider.of<DisciplinePerformancesProvider>(context).removePerformance(performance);
      },
    );
  }
}
