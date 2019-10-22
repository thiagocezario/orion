import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class GroupInfo extends StatelessWidget {
  final groupId;

  GroupInfo(this.groupId);

  void _exitGroup(BuildContext context) async {
    var data = {'group_id': groupId, 'user_id': Singleton().user.id};
    await SubscriptionResource.list(data).then((response) async {
      var result = subscriptionFromJson(response.body);
      await Client.unsubscribe(Singleton().jwtToken, result.first.id)
          .then((response) {
        Provider.of<MyGroupsProvider>(context).refreshMyGroups();
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
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.all(70.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            // color: Color(0xff606fe1),
            color: Color(0xff192376),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              elevation: 50.0,
              onPressed: () => _exitGroup(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Deixar grupo',
                      textAlign: TextAlign.right,
                      style: textStyle.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
