import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/components/absences/absence_dialog.dart';
import 'package:orion/components/absences/absence_item.dart';
import 'package:orion/components/empty_warning.dart';
import 'package:orion/components/groups/tabs/tab_subtitle.dart';
import 'package:orion/components/groups/tabs/tab_title.dart';
import 'package:orion/components/performances/performance_dialog.dart';
import 'package:orion/controllers/absence_controller.dart';
import 'package:orion/controllers/performance_controller.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:provider/provider.dart';

class PersonalPerformance extends StatefulWidget {
  final Discipline discipline;
  final Group group;

  PersonalPerformance(this.discipline, this.group);

  @override
  _PersonalPerformanceState createState() =>
      _PersonalPerformanceState(discipline, group);
}

class _PersonalPerformanceState extends State<PersonalPerformance> {
  final Discipline discipline;
  final Group group;

  _PersonalPerformanceState(this.discipline, this.group);

  Future _createPerformance() async {
    Performance result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PerformanceDialog(null);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      result.discipline = group.discipline;

      PerformanceController().create(context, performance: result, year: group.year);
    }
  }

  Future _createAbsence() async {
    Absence result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AbsenceDialog(null);
        },
        fullscreenDialog: true,
      ),
    );

    if (result != null) {
      result.discipline = group.discipline;

      AbsenceController().create(context, absence: result);
    }
  }

  void _editPerformance(Performance performance) async {
    Performance result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PerformanceDialog(performance);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      PerformanceController().update(context, performance: result);
    }
  }

  Widget buildEvent(BuildContext context) {
    DateTime date =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(DateTime.now().toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: 35,
          height: 25,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "${date.day}",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        Container(
          width: 35,
          height: 25,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              DateFormat.MMM("pt_BR").format(date),
            ),
          ),
        ),
      ],
    );
  }

  Widget performanceList(DisciplinePerformancesProvider performancesProvider) {
    if (performancesProvider.disciplinePerformances.length == 0) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          child: EmptyWarning(
              messsage: 'Você ainda não possui notas registradas!'),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Performance performance =
              performancesProvider.disciplinePerformances[index];

          return Column(
            key: UniqueKey(),
            children: <Widget>[
              ListTile(
                onTap: () => _editPerformance(performance),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("${performance.percentage.toString()}"),
                    double.parse(performance.percentage) >= 60
                        ? Icon(Icons.call_made, color: Colors.green[300])
                        : Icon(Icons.call_received, color: Colors.red[300]),
                  ],
                ),
                title: Text(performancesProvider
                    .disciplinePerformances[index].description),
                subtitle: Text(
                    "${performance.value.toString()} / ${performance.maxValue.toString()}"),
              ),
              Divider(
                height: 1,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
            ],
          );
        },
        childCount: performancesProvider.disciplinePerformances.length,
      ),
    );
  }

  Widget absencesList(DisciplineAbsencesProvider absencesProvider) {
    if (absencesProvider.disciplineAbsences.length == 0) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          child: EmptyWarning(
              messsage: 'Você ainda não possui faltas registradas!'),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      sliver: SliverGrid(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          // childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return AbsenceItem(
              key: UniqueKey(),
              absence: absencesProvider.disciplineAbsences[index],
            );
          },
          childCount: absencesProvider.disciplineAbsences.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisciplinePerformancesProvider>(
        builder: (context, performancesProvider, _) {
      return Consumer<DisciplineAbsencesProvider>(
          builder: (context, absencesProvider, _) {
        int absences = (absencesProvider.disciplineAbsences as List<Absence>)
            .fold(0, (sum, item) {
          return sum + item.quantity;
        }) as int;

        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: TabTitle(title: 'Desempenho Pessoal'),
            ),
            SliverToBoxAdapter(
              child:
                  TabSubtitle(title: 'Notas', onAddPressed: _createPerformance),
            ),
            performanceList(performancesProvider),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 15),
            ),
            SliverToBoxAdapter(
              child: TabSubtitle(
                  title: 'Faltas $absences', onAddPressed: _createAbsence),
            ),
            absencesList(absencesProvider),
          ],
        );
      });
    });
  }
}
