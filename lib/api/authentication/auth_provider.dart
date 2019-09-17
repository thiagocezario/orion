import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orion/api/user/client.dart';
import 'package:orion/model/user.dart';

class AuthProvider extends ChangeNotifier {
 
  String _accessToken = '';
  // store role user object?

  get accessToken => _accessToken;

  Future signIn(User user) {
    return Client.signIn(user).then((response) {
      
      var data = jsonDecode(response.body);
      _accessToken = data['token'];
      notifyListeners();
    });
  }
}