import 'package:flutter/foundation.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';

class MyGroupsProvider extends ChangeNotifier {
  List<Group> _myGroups = List();

  get myGroups => _myGroups;

  void refreshMyGroups() async {
    await Client.listGroups(Singleton().jwtToken, Singleton().user.id).then((response) {
      _myGroups = groupFromJson(response.body);
      notifyListeners();
    });
  }
}