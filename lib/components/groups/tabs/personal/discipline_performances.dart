import 'package:flutter/material.dart';
import 'package:orion/components/groups/tabs/tab_title.dart';
import 'package:orion/components/performances/performance_dialog.dart';
import 'package:orion/controllers/performance_controller.dart';
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
      PerformanceController.update(context, performance: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisciplinePerformancesProvider>(
      builder: (context, disciplineProvider, _) => CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TabTitle(title: 'Notas'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Performance performance =
                    disciplineProvider.disciplinePerformances[index];

                return Column(
                  key: UniqueKey(),
                  children: <Widget>[
                    ListTile(
                      onTap: () => _editPerformance(performance),
                      leading: Text("${performance.percentage.toString()} %"),
                      title: Text(disciplineProvider
                          .disciplinePerformances[index].description),
                      subtitle: Text(
                          "${performance.value.toString()} / ${performance.maxValue.toString()}"),
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
              childCount: disciplineProvider.disciplinePerformances.length,
            ),
          )
        ],
      ),
    );
  }
}
