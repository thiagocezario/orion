import 'package:flutter/material.dart';
import 'package:orion/model/subscriptions.dart';

class GroupUsers extends StatefulWidget {
  @override
  _GroupUsersState createState() => _GroupUsersState();
}

class _GroupUsersState extends State<GroupUsers> {
  List<Subscriptions> subs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 30,
      itemBuilder: (context, index) {
        return ListTile(
          // title: Text(subs[index].student.name),
          // subtitle: Text(subs[index].student.email),
          title: Text('Student $index'),
          subtitle: Text('Email $index'),
          trailing: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        );
      },
    );
  }
}