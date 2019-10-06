import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';

class SubscriptionsProvider with ChangeNotifier {
  List<Subscriptions> _subscriptions = List();

  get subscriptions => _subscriptions;

  void fetchSubscriptions(String groupId) async {
    await Client.listSubscriptions(Singleton().jwtToken, groupId, Singleton().user.id.toString()).then((response) {
      _subscriptions = subscriptionsFromJson(response.body);
      notifyListeners();
    });
  }
}