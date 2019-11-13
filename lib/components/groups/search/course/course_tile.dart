import 'package:flutter/material.dart';
import 'package:orion/model/course.dart';

class CourseTile extends StatelessWidget {
  final Course course;

  CourseTile(this.course);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.computer),
      title: Text(
        course.name,
      ),
      trailing: Container(
        height: 50,
        width: 50,
        child: Row(
          children: <Widget>[
            Icon(Icons.people),
            Text(
              course.metadata.subscriptions.toString(),
            ),
          ],
        ),
      ),
      onTap: () => {Navigator.of(context).pop(course)},
    );
  }
}
