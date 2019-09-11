import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';

class GroupServices {
  static Future filterGroups(Group groupInfo) async {
    List<Group> groupsFound = List();
    List<Group> allGroups = GroupCards.groups;

    for (var group in allGroups) {
      if (group.institutionName == groupInfo.institutionName) {
            groupsFound.add(group);
          }
    }

    return groupsFound;
  }
}

/**
 * group.institutionId == groupInfo.institutionId &&
          group.courseId == groupInfo.courseId &&
          group.disciplineId == groupInfo.disciplineId
 */