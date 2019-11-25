import 'package:flutter/material.dart';
import 'package:orion/components/absences/absence_dialog.dart';
import 'package:orion/controllers/absence_controller.dart';
import 'package:orion/model/absence.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';

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
        AbsenceController.update(context, absence: result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = absence.date;
    return InkWell(
      onTap: _editAbsence,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: themeColor),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                absence.quantity.toString(),
                style: TextStyle(
                  color: themeColor,
                  fontSize: 25,
                ),
              ),
              Text('${date.day}/${date.month}'),
            ],
          ),
        ),
      ),
    );
  }
}
