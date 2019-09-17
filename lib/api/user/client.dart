
import 'dart:convert';

import 'package:orion/model/user.dart';
import 'package:http/http.dart' as http;

class Client {
  static final String _baseUrl = 'http://localhost:3000/api';

  static Future signIn(User user) async {
    var data = {'email': user.email, 'password': user.password};
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    return http.post('$_baseUrl/sessions',
      body: json.encode(data),
      headers: headers,
    ).timeout(Duration(
      seconds: 5
    ));
  }

  static Future createUser(User user) async {
    var data = {'email': user.email, 'password': user.password};
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    return http.post('$_baseUrl/users',
      body: json.encode(data),
      headers: headers
    );
  }

  static Future listGroups(User user) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    return http.get('$_baseUrl/api/groups',
      // body: json.encode(data),
      headers: headers
    );
  }

  static Future listInstitutions(name) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    return http.get('$_baseUrl/api/institutions',
      headers: headers
    );
  }

  static Future listCourses(name, institutionId) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    return http.get('$_baseUrl/api/courses',
      headers: headers
    );
  }

  static Future listDisciplines(name, institutionId, courseId) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    return http.get('$_baseUrl/api/disciplines',
      headers: headers
    );
  }
}
