import 'package:flutter/foundation.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';

class MyGroupsProvider extends ChangeNotifier {
  List<Group> _myGroups = List();

  get myGroups => _myGroups;

  void refreshMyGroups() async {
    var data = {'user_id': Singleton().user.id.toString()};
    await GroupResource.list(data).then(handleResponse);
  }

  void handleResponse(dynamic response) {
    _myGroups = groupFromJson(response.body);
    notifyListeners();
  }
}
