import 'package:flutter/foundation.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';

class GroupRecomendationsProvider extends ChangeNotifier {
  List<Group> _groupRecomendations = List();

  get groupRecomendations => _groupRecomendations;

  void refreshMyRecomendations() async {
    await Client.listGroupRecomendations(Singleton().jwtToken).then((response) {
      _groupRecomendations = groupFromJson(response.body);
      notifyListeners();
    });
  }
}