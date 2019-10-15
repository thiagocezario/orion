import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/performances/performance_dialog.dart';
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
  _DisciplinePerformanceState createState() =>
      _DisciplinePerformanceState(discipline, group);
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

  Future _editPerformance(Performance performance) async {
    Performance result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PerformanceDialog(performance);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      await Client.updatePerformance(Singleton().jwtToken, result.id,
              result.description, result.value, result.maxValue)
          .then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }

  Future _createPerformance() async {
    Performance result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PerformanceDialog(null);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      await Client.createPerformance(Singleton().jwtToken, group.discipline.id,
              result.description, result.value, result.maxValue)
          .then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }

  // TODO: Remover requisições desnecessarias
  Future _popUpMenuActions(String action, Performance performance, String value,
      String maxValue) async {
    if (action == 'Editar') {
      _editPerformance(performance);
    } else if (action == 'Deletar') {
      await Client.deletePerformance(Singleton().jwtToken, performance.id)
          .then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PopupMenuButton<String> eventActions(Performance performance) {
      return PopupMenuButton<String>(
        onSelected: (String actionSelected) => _popUpMenuActions(
            actionSelected, performance, 0.toString(), 100.toString()),
        itemBuilder: (BuildContext context) => _popUpMenuItems,
      );
    }

    return Consumer<DisciplinePerformancesProvider>(
      builder: (context, disciplineProvider, _) => Container(
          child: ListView.builder(
        itemCount: disciplineProvider.disciplinePerformances.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: primaryButtonColor,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  elevation: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Adicionar nova nota',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,

                      ),
                    ],
                  ),
                  onPressed: () async => await _createPerformance(),
                ),
              ),
            );
          }

          return ListTile(
            leading: Text(
                "${disciplineProvider.disciplinePerformances[index - 1].percentage.toString()} %"),
            title: Text(disciplineProvider
                .disciplinePerformances[index - 1].description),
            subtitle: Text(
                "${disciplineProvider.disciplinePerformances[index - 1].value.toString()} / ${disciplineProvider.disciplinePerformances[index - 1].maxValue.toString()}"),
            trailing: eventActions(
                disciplineProvider.disciplinePerformances[index - 1]),
          );
        },
      )),
    );
  }
}
