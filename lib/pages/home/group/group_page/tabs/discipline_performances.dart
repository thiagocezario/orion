import 'package:flutter/material.dart';
import 'package:orion/components/performances/performance_cards.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:provider/provider.dart';

class DisciplinePerformance extends StatefulWidget {
  final Discipline discipline;

  DisciplinePerformance(this.discipline);

  @override
  _DisciplinePerformanceState createState() => _DisciplinePerformanceState(discipline);
}

class _DisciplinePerformanceState extends State<DisciplinePerformance> {
  final Discipline discipline;

  _DisciplinePerformanceState(this.discipline);

  @override
  Widget build(BuildContext context) {
    return Consumer<DisciplinePerformancesProvider>(
      builder: (context, disciplinePerformancesProvider, _) => Container(
        alignment: Alignment.center,
        child: PerformanceCards().getPerformanceCards(context, disciplinePerformancesProvider.disciplinePerformances),
      ),
    );
  }
}
