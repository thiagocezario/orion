import 'package:flutter/material.dart';
import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/performances/performance_dialog.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:provider/provider.dart';

class DisciplinePerformance extends StatefulWidget {
  final Discipline discipline;
  final Group group;

  DisciplinePerformance(this.discipline, this.group);

  @override
  _DisciplinePerformanceState createState() =>
      _DisciplinePerformanceState(discipline, group);
}

class _DisciplinePerformanceState extends State<DisciplinePerformance> {
  final Discipline discipline;
  final Group group;

  _DisciplinePerformanceState(this.discipline, this.group);

  void _editPerformance(Performance performance) async {
    Performance result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PerformanceDialog(performance);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      await PerformanceResource.updateObject(result).then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }

  void _createPerformance() async {
    Performance result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PerformanceDialog(null);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      result.discipline = discipline;

      await PerformanceResource.createObject(result).then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisciplinePerformancesProvider>(
      builder: (context, disciplineProvider, _) => Container(
          child: ListView.builder(
        itemCount: disciplineProvider.disciplinePerformances.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: CustomMaterialButton('Adicionar nota', () {
                _createPerformance();
              }),
            );
          }

          var performance =
              disciplineProvider.disciplinePerformances[index - 1];

          return ListTile(
            onTap: () => _editPerformance(performance),
            leading: Text("${performance.percentage.toString()} %"),
            title: Text(disciplineProvider
                .disciplinePerformances[index - 1].description),
            subtitle: Text(
                "${performance.value.toString()} / ${performance.maxValue.toString()}"),
          );
        },
      )),
    );
  }
}
