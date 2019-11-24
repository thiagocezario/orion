import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/absence_resource.dart';
import 'package:orion/components/absences/absence_dialog.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:provider/provider.dart';

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

  void _editAbsence() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) {
        return AbsenceDialog(absence);
      },
      fullscreenDialog: true,
    ))
        .then((result) {
      if (result != null) {
        AbsenceResource.updateObject(result).then((response) {
          Provider.of<DisciplineAbsencesProvider>(context)
              .fetchAbsences(group.id.toString());
        });
      }
      print(context);
      // Navigator.of(context).pop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(absence.quantity.toString()),
      subtitle: Text(DateFormat('dd/MM/yyyy H:m').format(absence.date)),
      // trailing: ?,
      onTap: _editAbsence,
    );
  }
}
