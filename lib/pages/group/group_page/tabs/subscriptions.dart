import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';

class GroupUsers extends StatefulWidget {
  final Group group;

  GroupUsers(this.group);

  @override
  _GroupUsersState createState() => _GroupUsersState(group, true);
}

class _GroupUsersState extends State<GroupUsers> {
  List<Subscriptions> subs = List();
  final Group group;
  bool shouldCall = true;

  _GroupUsersState(this.group, this.shouldCall);

  // TODO: Convert to Provider;
  void getSubs() async {
    await Client.listSubscriptions(Singleton().jwtToken, group.id.toString(), "").then((response) {
      print(response.body);

      setState(() {
        subs = subscriptionsFromJson(response.body);
        shouldCall = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shouldCall) {
      getSubs();
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: subs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(subs[index].student.name),
          subtitle: Text(subs[index].student.email),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        );
      },
    );
  }
}