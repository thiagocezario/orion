import 'package:flutter/material.dart';
import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:provider/provider.dart';

class PerformanceController {
  DisciplinePerformancesProvider disciplinePerformancesProvider;

  setProviders(BuildContext context) {
    disciplinePerformancesProvider =
        Provider.of<DisciplinePerformancesProvider>(context);
  }

  refresh({discipline, year}) {
    disciplinePerformancesProvider.fetchPerformances(
        discipline.id.toString(), year);
  }

  create(context, {Performance performance, String year}) {
    setProviders(context);

    PerformanceResource.createObject(performance, year).then(
      (response) {
        refresh(discipline: performance.discipline);
      },
    );
  }

  update(context, {Performance performance}) {
    setProviders(context);

    PerformanceResource.updateObject(performance).then(
      (response) {
        refresh(discipline: performance.discipline);
      },
    );
  }

  remove(context, {Performance performance}) {
    setProviders(context);

    PerformanceResource.delete(performance.id.toString()).then(
      (response) {
        disciplinePerformancesProvider.removePerformance(performance);
      },
    );
  }
}
