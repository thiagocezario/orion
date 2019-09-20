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

  static Future listGroups(String token, int userId) async {
    var uri = Uri.http('10.0.2.2:3000', '/api/groups/', {"user_id": userId.toString()});
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    var response = await http
        .get(uri, headers: headers)
        .timeout(Duration(seconds: 5))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listInstitutions(String token, String name) async {
    var uri = Uri.http('10.0.2.2:3000', '/api/institutions/', {"name": name});
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    var response = await http
        // .get('$_baseUrl/api/institutions/name?$name', headers: headers)
        .get(uri, headers: headers)
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listCourses(String token, String name) async {
    var uri = Uri.http('10.0.2.2:3000', '/api/courses/', {"name": name});
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listDisciplines(String token, String name) async {
    var uri = Uri.http('10.0.2.2:3000', '/api/disciplines/', {"name": name});
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future subscribe(String token, int groupId) async {
    var data = {
      'group_id': groupId
    };
    var headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};
    var response = await http
        .post('$_baseUrl/api/subscriptions',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future searchGroups(String token, int institution, int course, int discipline) async {
    var uri = Uri.http('10.0.2.2:3000', '/api/groups/', {
      "institution_id": institution.toString(),
      "course_id":course.toString(),
      "discipline_id":discipline.toString()
      });

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future createGroup(String token, int institutionId, int courseId, int disciplineId, String name) async {
    var data = {
      "institution_id": institutionId.toString(),
      "course_id":courseId.toString(),
      "discipline_id":disciplineId.toString(),
      "name": name
    };
    
    var headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};
    var response = await http
        .post('$_baseUrl/api/groups',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }
}
