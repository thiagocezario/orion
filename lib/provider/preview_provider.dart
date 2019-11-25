import 'package:flutter/material.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/api/resources/subscription_resource.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/post.dart';
import 'package:orion/model/subscriptions.dart';

class PreviewProvider extends ChangeNotifier {
  Group group;
  List<Post> _posts;
  List<Event> _events;
  List<Subscription> _subscriptions;

  bool _loadingEvents;
  bool _loadingPosts;
  bool _loadingSubscriptions;

  get posts => _posts;
  get events => _events;
  get subscriptions => _subscriptions;

  get loadingEvents => _loadingEvents;
  get loadingPosts => _loadingPosts;
  get loadingSubscriptions => _loadingSubscriptions;

  void refreshAll(Group group) {
    this.group = group;
    clean();
    refreshEvents();
    refreshPosts();
    refreshSubscriptions();
  }

  void clean() {
    _posts = List();
    _events = List();
    _subscriptions = List();

    _loadingEvents = true;
    _loadingPosts = true;
    _loadingSubscriptions = true;
  }

  void refreshEvents() async {
    var data = {'group_id': group.id.toString()};
    await EventResource.list(data).then(handleEventsResponse);
  }

  void refreshPosts() async {
    var data = {'group_id': group.id.toString()};
    await PostResource.list(data).then(handlePostsResponse);
  }

  void refreshSubscriptions() async {
    var data = {'group_id': group.id.toString()};
    await SubscriptionResource.list(data).then(handleSubscriptionsResponse);
  }

  void handleEventsResponse(dynamic response) {
    this._events = eventFromJson(response.body);
    this._loadingEvents = false;
    notifyListeners();
  }

  void handlePostsResponse(dynamic response) {
    this._posts = postFromJson(response.body);
    this._loadingPosts = false;
    notifyListeners();
  }

  void handleSubscriptionsResponse(dynamic response) {
    this._subscriptions = subscriptionFromJson(response.body);
    this._loadingSubscriptions = false;
    notifyListeners();
  }
}
