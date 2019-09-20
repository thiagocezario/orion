import 'dart:convert';

import 'package:orion/model/user.dart';
import 'package:http/http.dart' as http;

class Client {
  static final String _baseUrl = 'http://10.0.2.2:3000';

  static Future signIn(User user) async {
    var data = {'email': user.email, 'password': user.password};
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var response = await http
        .post(
          '$_baseUrl/api/sessions',
          body: json.encode(data),
          headers: headers,
        )
        .timeout(Duration(seconds: 5))
        .catchError((e) {
      print(e);
    });

    print(response.toString());
    return response;
  }

  static Future createUser(User user) async {
    var data = {
      'name': user.name,
      'email': user.email,
      'password': user.password
    };
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var response = await http
        .post('$_baseUrl/api/students',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listGroups(User user) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var response = await http
        .get('$_baseUrl/api/groups', headers: headers)
        .timeout(Duration(seconds: 5))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listInstitutions() async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var response = await http
        .get('$_baseUrl/api/institutions', headers: headers)
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listCourses() async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var response = await http
        .get('$_baseUrl/api/courses', headers: headers)
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listDisciplines() async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var response = await http
        .get('$_baseUrl/api/disciplines', headers: headers)
        .catchError((e) {
      print(e);
    });

    return response;
  }
}
