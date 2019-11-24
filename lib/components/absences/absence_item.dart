import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/absence.dart';

class AbsenceItem extends StatefulWidget {
  final Absence absence;
  final Group group;

  AbsenceItem({Key key, this.absence, this.group}) : super(key: key);

  @override
  _AbsenceItemState createState() => _AbsenceItemState(absence, group);
}

class _AbsenceItemState extends State<AbsenceItem> {
  Absence absence;
  Group group;

  _AbsenceItemState(this.absence, this.group);

  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Editar', 'Deletar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();

  Future _popUpMenuActions(String action, Absence absence) async {
    if (action == 'Editar') {
      await _editAbsence(absence);
    } else if (action == 'Deletar') {
      await _deleteAbsence(absence);
    }
  }

  Future _deleteAbsence(Absence absence) async {
    // await AbsenceResource.delete(absence.id.toString()).then((response) {
    //   Provider.of<DisciplinePerformancesProvider>(context)
    //       .removeAbsence(absence);
    // });
  }

  Future _editAbsence(Absence absence) async {
    // DisciplinePerformancesProvider provider =
    //     Provider.of<DisciplinePerformancesProvider>(context);

    // Navigator.of(context)
    //     .push(MaterialPageRoute(
    //   builder: (context) {
    //     return GroupAbsenceDialog(absence, group);
    //   },
    //   fullscreenDialog: true,
    // ))
    //     .then((resultAbsence) {
    //   if (resultAbsence != null) {
    //     AbsenceResource.updateObject(resultAbsence).then((response) {
    //       provider.fetchAbsences(group.id.toString());
    //     });
    //   }
    // });
  }

  PopupMenuButton<String> actions(Absence absence) {
    return PopupMenuButton<String>(
      onSelected: (String selected) => _popUpMenuActions(selected, absence),
      itemBuilder: (BuildContext context) => _popUpMenuItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(absence.quantity.toString()),
      subtitle: Text(DateFormat('dd/MM/yyyy H:m').format(absence.date)),
      trailing: actions(absence),
    );
  }
}
