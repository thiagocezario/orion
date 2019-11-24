import 'package:flutter/material.dart';
import 'package:orion/model/performance.dart';
import 'package:orion/model/user.dart';

class PerformanceItem extends StatefulWidget {
  final Performance performance;

  PerformanceItem({Key key, this.performance}) : super(key: key);

  @override
  _PerformanceItemState createState() => _PerformanceItemState(performance);
}

class _PerformanceItemState extends State<PerformanceItem> {
  Performance performance;

  _PerformanceItemState(this.performance);

  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Editar', 'Deletar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();

  Future _popUpMenuActions(String action, Performance performance) async {
    if (action == 'Editar') {
      await _editPerformance(performance);
    } else if (action == 'Deletar') {
      await _deletePerformance(performance);
    }
  }

  Future _deletePerformance(Performance performance) async {
    // await PerformanceResource.delete(performance.id.toString())
    //     .then((response) {
    //   Provider.of<GroupPerformancesProvider>(context)
    //       .removePerformance(performance);
    // });
  }

  Future _editPerformance(Performance performance) async {
    // GroupPerformancesProvider provider =
    //     Provider.of<GroupPerformancesProvider>(context);

    // Navigator.of(context)
    //     .push(MaterialPageRoute(
    //   builder: (context) {
    //     return GroupPerformanceDialog(performance, group);
    //   },
    //   fullscreenDialog: true,
    // ))
    //     .then((resultPerformance) {
    //   if (resultPerformance != null) {
    //     PerformanceResource.updateObject(resultPerformance).then((response) {
    //       provider.fetchPerformances(group.id.toString());
    //     });
    //   }
    // });
  }

  PopupMenuButton<String> performanceActions(Performance performance) {
    if (performance.student.id == Singleton().user.id) {
      return PopupMenuButton<String>(
        onSelected: (String actionSelected) =>
            _popUpMenuActions(actionSelected, performance),
        itemBuilder: (BuildContext context) => _popUpMenuItems,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: UniqueKey(),
      leading: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Text("${performance.percentage}%"),
      ),
      title: Text(performance.description),
      subtitle: Text(
          "${performance.value.toString()} / ${performance.maxValue.toString()}"),
      trailing: performanceActions(performance),
      isThreeLine: true,
    );
  }
}
