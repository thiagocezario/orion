import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';

class GroupServices {
  static Future filterGroups(int institutionId, int courseId, int disciplineId) async {
    List<Group> groupsFound = List();
    List<Group> allGroups = GroupCards.groups;

    for (var group in allGroups) {
      if (group.institution.id == institutionId &&
          group.course.id == courseId &&
          group.discipline.id == disciplineId) {
            groupsFound.add(group);
          }
    }

    return groupsFound;
  }
}