import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:provider/provider.dart';

class DisciplinePerformance extends StatefulWidget {
  final Discipline discipline;
  final Group group;

  DisciplinePerformance(this.discipline, this.group);

  @override
  _DisciplinePerformanceState createState() => _DisciplinePerformanceState(discipline, group);
}

class _DisciplinePerformanceState extends State<DisciplinePerformance> {
  final Discipline discipline;
  final Group group;

  _DisciplinePerformanceState(this.discipline, this.group);

  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Editar', 'Deletar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();


  // TODO: Remover requisições desnecessarias
  Future _popUpMenuActions(String action, Performance performance, String value, String maxValue) async {
    if (action == 'Editar') {
      await Client.updatePerformance(Singleton().jwtToken, performance.id, "", value, maxValue).then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    } else if (action == 'Deletar') {
      await Client.deletePerformance(Singleton().jwtToken, performance.id).then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    PopupMenuButton<String> eventActions(Performance performance) {
        return PopupMenuButton<String>(
          onSelected: (String actionSelected) =>
              _popUpMenuActions(actionSelected, performance, 0.toString(), 100.toString()),
          itemBuilder: (BuildContext context) => _popUpMenuItems,
        );
    }

    return Consumer<DisciplinePerformancesProvider>(
      builder: (context, disciplineProvider, _) => Container(
        child: ListView.builder(
          itemCount: disciplineProvider.disciplinePerformances.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text("${disciplineProvider.disciplinePerformances[index].percentage.toString()}"),
              title: Text(disciplineProvider.disciplinePerformances[index].description),
              subtitle: Text("${disciplineProvider.disciplinePerformances[index].value.toString()} / ${disciplineProvider.disciplinePerformances[index].maxValue.toString()}"),
              trailing: eventActions(disciplineProvider.disciplinePerformances[index]),
            );
          },
        )
      ),
    );
  }
}
