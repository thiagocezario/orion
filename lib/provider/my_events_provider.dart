import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/event_resource.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/user.dart';

class MyEventsProvider with ChangeNotifier {
  List<Event> _myEvents = List();

  get myEvents => _myEvents;

  void fetchEvents() async {
    var data = {'user_id': Singleton().user.id.toString()};
    return await EventResource.list(data).then(handleResponse);
  }

  void removeEvent(Event event) {
    _myEvents.removeWhere((Event i) {
      return i.id == event.id;
    });
    notifyListeners();
  }

  void handleResponse(dynamic response) {
    _myEvents = eventFromJson(response.body);
    notifyListeners();
  }
}
