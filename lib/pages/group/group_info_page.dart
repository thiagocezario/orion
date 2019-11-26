import 'package:flutter/material.dart';
import 'package:orion/components/groups/tabs/group_info/group_info_exit.dart';
import 'package:orion/components/groups/tabs/group_info/group_info_name.dart';
import 'package:orion/components/groups/tabs/group_info/subscriptions_preview.dart';
import 'package:orion/components/groups/tabs/group_info/subscriptions_preview_header.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/components/groups/tabs/group_info/group_info_description.dart';
import 'package:orion/components/groups/tabs/group_info/group_info_sliver_list.dart';
import 'package:orion/pages/group/group_page.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class GroupInfoPage extends StatelessWidget {
  final Group group;

  GroupInfoPage(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(group.name),
      ),
      body: Consumer<SubscriptionsProvider>(
        builder: (context, subscriptionsState, _) => CustomScrollView(
          slivers: <Widget>[
            GroupInfoName(group),
            SliverToBoxAdapter(
              child: Divider(
                thickness: 1,
                height: 1,
              ),
            ),
            GroupInfoDescription(group),
            SliverToBoxAdapter(
              child: Divider(
                thickness: 20,
                height: 20,
              ),
            ),
            GroupInfoSliverList(group),
            SliverToBoxAdapter(
              child: Divider(
                thickness: 20,
                height: 20,
              ),
            ),
            SubscriptionsPreviewHeader(
              group: group,
              subscriptions: subscriptionsState.subscriptions,
            ),
            SubscriptionsPreview(
                subscriptionsState.subscriptions, 10, group),
            SliverToBoxAdapter(
              child: Divider(
                thickness: 20,
                height: 20,
              ),
            ),
            GroupInfoExit(group),
            SliverToBoxAdapter(
              child: Divider(
                thickness: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
