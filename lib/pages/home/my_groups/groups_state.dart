import 'package:flutter/widgets.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/home/my_groups/my_groups_page.dart';

class GroupsState with ChangeNotifier {
  List<Group> _groups;

  List<Group> get groups => _groups;

  set groups(List<Group> groups) {
    _groups = groups;
    notifyListeners();
  }

  set didChange(bool didChange) {
    if (didChange) {
      MyGroups().updateMyGroups();
    }
  }
}
