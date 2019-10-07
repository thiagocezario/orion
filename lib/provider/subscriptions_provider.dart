import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';

class SubscriptionsProvider with ChangeNotifier {
  List<Subscription> _subscriptions = List();

  get subscriptions => _subscriptions;

  void fetchSubscriptions(String groupId) async {
    await Client.listSubscriptions(Singleton().jwtToken, groupId, "").then((response) {
      _subscriptions = subscriptionFromJson(response.body);
      notifyListeners();
    });
  }
}