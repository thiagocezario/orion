import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/user.dart';

class GroupEventsProvider with ChangeNotifier {
  List<Event> _groupEvents = List();

  get groupEvents => _groupEvents;

  void fetchEvents(String groupId) async {
    await Client.listEvents(Singleton().jwtToken, groupId, Singleton().user.id).then((response) {
      _groupEvents = eventFromJson(response.body);
      notifyListeners();
    });
  }
}