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
  static refresh(context, {group}) {
    Provider.of<SubscriptionsProvider>(context)
        .fetchSubscriptions(group.id.toString());

    Provider.of<MyGroupsProvider>(context).refreshMyGroups();
    Provider.of<GroupRecomendationsProvider>(context).refreshMyRecomendations();
  }

  static create(context, {Group group}) {
    SubscriptionResource.subscribe(group.id.toString()).then(
      (response) {
        refresh(context, group: group);
      },
    );
  }

  static removeFromGroup(context, {Group group}) {
    MyGroupsProvider provider = Provider.of<MyGroupsProvider>(context);
    Subscription subscription = provider.subscriptionForGroup(group);

    remove(context, subscription: subscription);
  }

  static ban(context, {Subscription subscription}) {
    BanResource.createObject(subscription).then(
      (response) {
        refresh(context, group: subscription.group);
      },
    );
  }

  static unban(context, {Subscription subscription}) {
    BanResource.deleteObject(subscription).then(
      (response) {
        refresh(context, group: subscription.group);
      },
    );
  }

  static createManager(context, {Subscription subscription}) {
    ManagerResource.createObject(subscription).then(
      (response) {
        refresh(context, group: subscription.group);
      },
    );
  }

  static removeManager(context, {Subscription subscription}) {
    ManagerResource.deleteObject(subscription).then(
      (response) {
        refresh(context, group: subscription.group);
      },
    );
  }

  static remove(context, {Subscription subscription}) {
    SubscriptionResource.delete(subscription.id.toString()).then(
      (response) {
        refresh(context, group: subscription.group);
      },
    );
  }
}
