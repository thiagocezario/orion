import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/model/event.dart';

class GroupEventsProvider with ChangeNotifier {
  List<Event> _groupEvents = List();

  get groupEvents => _groupEvents;

  void fetchEvents(String groupId) async {
    var data = { 'group_id': groupId };
    return await EventResource.list(data).then(handleResponse);
  }

  void handleResponse(dynamic response) {
    _groupEvents = eventFromJson(response.body);
    notifyListeners();
  }
}
