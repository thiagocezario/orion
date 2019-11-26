import 'package:flutter/foundation.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/model/user.dart';

class MyGroupsProvider extends ChangeNotifier {
  List<Group> _myGroups = List();
  List<Subscription> _mySubscriptions = List();

  get myGroups => _myGroups;
  get mySubscriptions => _mySubscriptions;

  Subscription subscriptionForGroup(Group group) {
    print(_mySubscriptions.length);

    //return null;
    return _mySubscriptions.singleWhere((subscription) {
      return subscription.group != null && subscription.group.id == group.id;
    }, orElse: () => null);
  }

  void refreshMySubscriptions() async {
    var data = {'user_id': Singleton().user.id.toString()};
    await SubscriptionResource.list(data).then(handleSubscriptionsResponse);
  }

  void refreshMyGroups() async {
    var data = {'user_id': Singleton().user.id.toString()};
    await GroupResource.listAll(data).then(handleGroupsResponse).then(
      (response) {
        refreshMySubscriptions();
      },
    );
  }

  void removeGroup(Group group) {
    myGroups.removeWhere((Group i) {
      return i.id == group.id;
    });
    mySubscriptions.removeWhere((Subscription i) {
      return i.group.id == group.id;
    });
    notifyListeners();
  }

  void handleGroupsResponse(dynamic response) {
    _myGroups = groupFromJson(response.body);
    notifyListeners();
  }

  void handleSubscriptionsResponse(dynamic response) {
    _mySubscriptions = subscriptionFromJson(response.body);
  }
}
