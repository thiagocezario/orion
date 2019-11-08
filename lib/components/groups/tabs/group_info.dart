import 'package:flutter/material.dart';
import 'package:orion/model/group.dart';
import 'package:orion/components/groups/tabs/group_info/group_info_description.dart';
import 'package:orion/components/groups/tabs/group_info/group_info_sliver_list.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

import 'group_info/group_info_exit.dart';
import 'group_info/subscriptions_preview.dart';
import 'group_info/subscriptions_preview_header.dart';

class GroupInfo extends StatelessWidget {
  final Group group;

  GroupInfo(this.group);

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionsProvider>(
      builder: (context, subscriptionsState, _) => CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Divider(
              thickness: 20,
              height: 20,
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
          SubscriptionsPreview(subscriptionsState.subscriptions, 10),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 20,
              height: 20,
            ),
          ),
          GroupInfoExit(group),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
