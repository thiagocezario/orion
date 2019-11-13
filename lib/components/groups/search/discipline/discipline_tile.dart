import 'package:flutter/material.dart';
import 'package:orion/model/discipline.dart';

class DisciplineTile extends StatelessWidget {
  final Discipline discipline;

  DisciplineTile(this.discipline);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.class_),
      title: Text(
        discipline.name,
      ),
      trailing: Container(
        height: 50,
        width: 50,
        child: Row(
          children: <Widget>[
            Icon(Icons.people),
            Text(
              discipline.metadata.subscriptions.toString(),
            ),
          ],
        ),
      ),
      onTap: () => {Navigator.of(context).pop(discipline)},
    );
  }
}
