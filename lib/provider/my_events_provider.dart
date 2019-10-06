import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/event.dart';
import 'package:orion/model/user.dart';

class MyEventsProvider with ChangeNotifier {
  List<Event> _myEvents = List();

  get myEvents => _myEvents;

  void fetchEvents() async {
    await Client.listEvents(Singleton().jwtToken, "", Singleton().user.id).then((response) {
      _myEvents = eventFromJson(response.body);
      notifyListeners();
    });
  }
}