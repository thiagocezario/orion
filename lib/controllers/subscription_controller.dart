import 'package:flutter/material.dart';
import 'package:orion/api/resources/ban_resource.dart';
import 'package:orion/api/resources/manager_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionController {
  SubscriptionsProvider subscriptionsProvider;
  MyGroupsProvider myGroupsProvider;
  GroupRecomendationsProvider groupRecomendationsProvider;

  setProviders(BuildContext context) {
    subscriptionsProvider = Provider.of<SubscriptionsProvider>(context);
    myGroupsProvider = Provider.of<MyGroupsProvider>(context);
    groupRecomendationsProvider =
        Provider.of<GroupRecomendationsProvider>(context);
  }

  refresh({group}) {
    subscriptionsProvider.fetchSubscriptions(group.id.toString());

    myGroupsProvider.refreshMyGroups();
    groupRecomendationsProvider.refreshMyRecomendations();
  }

  Future create(context, {Group group}) {
    setProviders(context);

    return SubscriptionResource.subscribe(group.id.toString()).then(
      (response) {
        print(response.body);
        refresh(group: group);
      },
    );
  }

  removeFromGroup(context, {Group group}) {
    MyGroupsProvider provider = Provider.of<MyGroupsProvider>(context);
    Subscription subscription = provider.subscriptionForGroup(group);

    remove(context, subscription: subscription);
  }

  ban(context, {Subscription subscription}) {
    setProviders(context);

    BanResource.createObject(subscription).then(
      (response) {
        refresh(group: subscription.group);
      },
    );
  }

  unban(context, {Subscription subscription}) {
    setProviders(context);

    BanResource.deleteObject(subscription).then(
      (response) {
        refresh(group: subscription.group);
      },
    );
  }

  createManager(context, {Subscription subscription}) {
    setProviders(context);

    ManagerResource.createObject(subscription).then(
      (response) {
        refresh(group: subscription.group);
      },
    );
  }

  removeManager(context, {Subscription subscription}) {
    setProviders(context);

    ManagerResource.deleteObject(subscription).then(
      (response) {
        refresh(group: subscription.group);
      },
    );
  }

  remove(context, {Subscription subscription}) {
    setProviders(context);

    SubscriptionResource.delete(subscription.id.toString()).then(
      (response) {
        refresh(group: subscription.group);
      },
    );
  }
}
