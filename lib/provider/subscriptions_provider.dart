import 'package:flutter/material.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionsProvider with ChangeNotifier {
  List<Subscription> _subscriptions = List();

  get subscriptions => _subscriptions;

  void fetchSubscriptions(String groupId) async {
    var data = {'group_id': groupId};
    return await SubscriptionResource.list(data).then(handleResponse);
  }

  void removeSubscription(Subscription subscription) {
    subscriptions.removeWhere((Subscription i) {
      return i.id == subscription.id;
    });
    notifyListeners();
  }

  void handleResponse(dynamic response) {
    _subscriptions = subscriptionFromJson(response.body);
    notifyListeners();
  }
}
