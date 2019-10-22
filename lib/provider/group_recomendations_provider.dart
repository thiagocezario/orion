import 'package:flutter/foundation.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/model/group.dart';

class GroupRecomendationsProvider extends ChangeNotifier {
  List<Group> _groupRecomendations = List();

  get groupRecomendations => _groupRecomendations;

  void refreshMyRecomendations() async {
    await GroupResource.listRecomendations(null).then(handleResponse);
  }

  void handleResponse(dynamic response) {
    _groupRecomendations = groupFromJson(response.body);
    notifyListeners();
  }
}
