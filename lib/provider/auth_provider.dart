import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orion/api/resources/session_resource.dart';
import 'package:orion/model/user.dart';

class AuthProvider extends ChangeNotifier {
  String _accessToken = '';
  User _user = User();

  get accessToken => _accessToken;

  Future signIn(User user) {
    return SessionResource.signInObject(user).then(handleResponse);
  }

  void handleResponse(dynamic response) {
    var data = jsonDecode(response.body);
    _accessToken = data['token'];
    _user.id = data['student']['id'];
    _user.email = data['student']['email'];
    _user.name = data['student']['name'];

    if (_accessToken != null && _accessToken != '') {
      Singleton().user = _user;
      Singleton().jwtToken = _accessToken;
    }

    notifyListeners();
  }
}
