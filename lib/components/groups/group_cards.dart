import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/controllers/group_controller.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/components/groups/group_item.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';
import 'package:orion/pages/group/group_page.dart';

class GroupCardsList extends StatelessWidget {
  final List<Group> groups;

  GroupCardsList(this.groups);

  void onItemTap(BuildContext context, Group group) {
    GroupController.refreshAll(context, group: group);

    var data = {
      'group_id': group.id.toString(),
      'user_id': Singleton().user.id.toString()
    };

    SubscriptionResource.list(data).then((response) {
      var sub = subscriptionFromJson(response.body);

      if (sub.first.student.id == Singleton().user.id && sub.first.manager) {
        GroupPage.isUserManager = true;
      } else {
        GroupPage.isUserManager = false;
      }
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GroupPage(group)));
  }

  Widget _buildGroupCard(BuildContext context, Group group) {
    return InkWell(
      key: UniqueKey(),
      onTap: () {
        onItemTap(context, group);
      },
      child: GroupCard(group: group),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(left: 10, right: 10),
        separatorBuilder: (context, index) {
          return Divider(
            indent: 5,
            endIndent: 5,
          );
        },
        physics: BouncingScrollPhysics(),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return _buildGroupCard(context, groups[index]);
        });
  }
}
