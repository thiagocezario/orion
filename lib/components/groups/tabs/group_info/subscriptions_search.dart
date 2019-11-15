import 'package:flutter/material.dart';
import 'package:orion/components/groups/tabs/group_info/subscription_list.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/pages/group/group_page.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionsSearch extends SearchDelegate {
  final Group group;

  SubscriptionsSearch(this.group);

  List<Subscription> _filterSubscriptions(
      String query, List<Subscription> subscriptions) {
    List<Subscription> filteredSubscriptions = List();

    if (query == '') return subscriptions;

    for (var subscription in subscriptions) {
      if (subscription.student.name
          .toLowerCase()
          .contains(query.toLowerCase())) {
        filteredSubscriptions.add(subscription);
      }
    }

    return filteredSubscriptions;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<SubscriptionsProvider>(
      builder: (context, subProvider, _) => SubscriptionList(
          _filterSubscriptions(query, subProvider.subscriptions),
          group,
          GroupPage.isUserManager),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<SubscriptionsProvider>(
      builder: (context, subProvider, _) => SubscriptionList(
          subProvider.subscriptions, group, GroupPage.isUserManager),
    );
  }
}
