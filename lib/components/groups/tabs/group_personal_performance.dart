import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/absence_resource.dart';
import 'package:orion/api/resources/performance_resource.dart';
import 'package:orion/components/absences/absence_dialog.dart';
import 'package:orion/components/absences/absence_item.dart';
import 'package:orion/components/groups/tabs/tab_subtitle.dart';
import 'package:orion/components/groups/tabs/tab_title.dart';
import 'package:orion/components/performances/performance_dialog.dart';
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

      await PerformanceResource.createObject(result).then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
    }
  }

  Future _createAbsence() async {
    Absence result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AbsenceDialog(null);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      result.discipline = group.discipline;

      await AbsenceResource.createObject(result).then((response) {
        Provider.of<DisciplineAbsencesProvider>(context)
            .fetchAbsences(group.id.toString());
      });
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
      await PerformanceResource.updateObject(result).then((response) {
        Provider.of<DisciplinePerformancesProvider>(context)
            .fetchPerformances(group.id.toString());
      });
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
              DateFormat.MMM().format(date),
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
          child: Text(
            'Você ainda não possui notas registradas!',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
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
                leading: Text("${performance.percentage.toString()} %"),
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
          child: Text(
            'Você ainda não possui faltas registradas!',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Absence absence = absencesProvider.disciplineAbsences[index];

          return Column(
            key: UniqueKey(),
            children: <Widget>[
              AbsenceItem(
                absence: absence,
                group: group,
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
        childCount: absencesProvider.disciplineAbsences.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisciplinePerformancesProvider>(
        builder: (context, performancesProvider, _) {
      return Consumer<DisciplineAbsencesProvider>(
          builder: (context, absencesProvider, _) {
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
              child: TabSubtitle(title: 'Faltas', onAddPressed: _createAbsence),
            ),
            absencesList(absencesProvider),
            // SliverGrid(
            //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 250.0,
            //     mainAxisSpacing: 10.0,
            //     crossAxisSpacing: 10.0,
            //     childAspectRatio: 4.0,
            //   ),
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return buildEvent(context);
            //     },
            //     childCount: 12,
            //   ),
            // )
          ],
        );
      });
    });
  }
}
