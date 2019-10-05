import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';

class GroupInfo extends StatelessWidget {
  final groupId;

  GroupInfo(this.groupId);

  void _exitGroup(BuildContext context) async {
    await Client.listSubscriptions(
            Singleton().jwtToken, groupId, Singleton().user.id.toString())
        .then((response) async {
      var result = subscriptionsFromJson(response.body);
      await Client.unsubscribe(Singleton().jwtToken, result.first.id)
          .then((response) {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.all(50),
          child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text('Deixar grupo'), Icon(Icons.exit_to_app)],
            ),
            onPressed: () => _exitGroup(context),
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
