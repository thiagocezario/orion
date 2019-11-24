import 'package:flutter/material.dart';
import 'package:orion/components/absences/absence_item.dart';
import 'package:orion/components/groups/tabs/tab_title.dart';
import 'package:orion/model/discipline.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:provider/provider.dart';

class DisciplineAbsence extends StatefulWidget {
  final Discipline discipline;
  final Group group;

  DisciplineAbsence(this.discipline, this.group);

  @override
  _DisciplineAbsenceState createState() =>
      _DisciplineAbsenceState(discipline, group);
}

class _DisciplineAbsenceState extends State<DisciplineAbsence> {
  final Discipline discipline;
  final Group group;

  _DisciplineAbsenceState(this.discipline, this.group);

  @override
  Widget build(BuildContext context) {
    return Consumer<DisciplineAbsencesProvider>(
      builder: (context, disciplineProvider, _) => CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TabTitle(title: 'Faltas'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Absence absence = disciplineProvider.disciplineAbsences[index];

                return Column(
                  key: UniqueKey(),
                  children: <Widget>[
                    AbsenceItem(
                      absence: absence,
                      group: group,
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                );
              },
              childCount: disciplineProvider.disciplineAbsences.length,
            ),
          )
        ],
      ),
    );
  }
}
