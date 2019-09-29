import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orion/model/user.dart';

import '../client.dart';

class AuthProvider extends ChangeNotifier {
 
  String _accessToken = '';
  User _user = User();
  // store role user object?

  get accessToken => _accessToken;

  Future signIn(User user) {
    return Client.signIn(user).then((response) {
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
    });
  }
}