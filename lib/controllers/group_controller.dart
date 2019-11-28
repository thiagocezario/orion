import 'package:orion/model/event.dart';
import 'package:orion/model/subscriptions.dart';
import 'package:orion/provider/discipline_absences_provider.dart';
import 'package:orion/provider/discipline_performances_provider.dart';
import 'package:orion/provider/group_events_provider.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:orion/provider/subscriptions_provider.dart';
import 'package:provider/provider.dart';

class GroupController {
  static refreshAll(context, {group}) {
    refreshPosts(context, group: group);
    refreshEvents(context, group: group);
    refreshSubscriptions(context, group: group);
    refreshPerformances(context, group: group);
    refreshAbsences(context, group: group);
  }

  static refreshPosts(context, {group}) {
    Provider.of<GroupPostsProvider>(context).fetchPosts(group.id.toString());
  }

  static refreshEvents(context, {group}) {
    Provider.of<GroupEventsProvider>(context).fetchEvents(group.id.toString());
    Provider.of<MyEventsProvider>(context).fetchEvents();
  }

  static refreshSubscriptions(context, {group}) {
    Provider.of<SubscriptionsProvider>(context)
        .fetchSubscriptions(group.id.toString());
  }

  static refreshPerformances(context, {group}) {
    Provider.of<DisciplinePerformancesProvider>(context)
        .fetchPerformances(group.discipline.id.toString(), group.year);
  }

  static refreshAbsences(context, {group}) {
    Provider.of<DisciplineAbsencesProvider>(context)
        .fetchAbsences(group.discipline.id.toString());
  }

  static removeEvent(context, {Event event}) {
    Provider.of<GroupEventsProvider>(context).removeEvent(event);
    Provider.of<MyEventsProvider>(context).removeEvent(event);
  }

  static Subscription mySubscription(context, {group}) {
    MyGroupsProvider provider = Provider.of<MyGroupsProvider>(context);

    return provider.subscriptionForGroup(group);
  }
}
