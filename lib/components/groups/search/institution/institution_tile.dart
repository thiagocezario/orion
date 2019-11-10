import 'package:flutter/material.dart';
import 'package:orion/model/institution.dart';

class InstitutionTile extends StatelessWidget {
  final Institution institution;

  InstitutionTile(this.institution);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.school),
      title: Text(
        institution.name,
      ),
      trailing: Container(
        height: 50,
        width: 50,
        child: Row(
          children: <Widget>[
            Icon(Icons.people),
            Text(
              institution.metadata.subscriptions.toString(),
            ),
          ],
        ),
      ),
      onTap: () => {Navigator.of(context).pop(institution)},
    );
  }
}
