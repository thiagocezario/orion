import 'dart:convert';

import 'package:orion/model/user.dart';
import 'package:http/http.dart' as http;

class Client {

  // change if you aew running on android emulator
  // static final String _base = "10.0.2.2:3000";
  static final String _base = 'localhost:3000';

  static final String _baseUrl = 'http://$_base';

  static Map<String, String> _defaultHeader() {
    return {'Content-Type': 'application/json; charset=UTF-8'};
  }

  static Map<String, String> _defaultAuthHeader(String token) {
    return {}
      ..addAll(_defaultHeader())
      ..addAll({'Authorization': 'Bearer $token'});
  }

  static Future signIn(User user) async {
    var headers = _defaultHeader();
    var data = {'email': user.email, 'password': user.password};

    var response = await http
        .post('$_baseUrl/api/sessions',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 5))
        .catchError((e) {
      print(e);
    });

    print(response.toString());
    return response;
  }

  static Future createUser(User user) async {
    var headers = _defaultHeader();
    var data = {
      'name': user.name,
      'email': user.email,
      'password': user.password
    };

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
    var headers = _defaultAuthHeader(token);
    var uri = Uri.http(_base, '/api/groups/', {"user_id": userId.toString()});

    var response = await http
        .get(uri, headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listInstitutions(String token, String name) async {
    var headers = _defaultAuthHeader(token);
    var uri = Uri.http(_base, '/api/institutions/', {"name": name});

    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listCourses(String token, String name) async {
    var headers = _defaultAuthHeader(token);
    var uri = Uri.http(_base, '/api/courses/', {"name": name});

    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listDisciplines(String token, String name) async {
    var headers = _defaultAuthHeader(token);
    var uri = Uri.http(_base, '/api/disciplines/', {"name": name});

    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future listSubscriptions(String token, String groupId, String userId) async {
    var headers = _defaultAuthHeader(token);
    var data = {'group_id': groupId.toString(), 'user_id': userId.toString()};

    Uri uri = Uri.http(_base, '/api/subscriptions/', data);
    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future subscribe(String token, int groupId) async {
    var headers = _defaultAuthHeader(token);
    var data = {'group_id': groupId};

    var response = await http
        .post('$_baseUrl/api/subscriptions',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future searchGroups(
      String token, int institution, int course, int discipline) async {
    var headers = _defaultAuthHeader(token);
    var uri = Uri.http(_base, '/api/groups/', {
      "institution_id": institution.toString(),
      "course_id": course.toString(),
      "discipline_id": discipline.toString()
    });

    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future createGroup(String token, int institutionId, int courseId,
      int disciplineId, String name) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "institution_id": institutionId.toString(),
      "course_id": courseId.toString(),
      "discipline_id": disciplineId.toString(),
      "name": name
    };

    var response = await http
        .post('$_baseUrl/api/groups', body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future unsubscribe(String token, int subscriptionId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
        .delete('$_baseUrl/api/subscriptions/$subscriptionId', headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future createManager(String token, int subscriptionId) async {
    var headers = _defaultAuthHeader(token);
    var data = {"subscription_id": subscriptionId.toString()};

    var response = await http
        .post('$_baseUrl/api/managers',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future deleteManager(String token, int subscriptionId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
        .delete('$_baseUrl/api/managers/$subscriptionId', headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future createBan(String token, int subscriptionId) async {
    var headers = _defaultAuthHeader(token);
    var data = {"subscription_id": subscriptionId.toString()};

    var response = await http
        .post('$_baseUrl/api/bans', body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future deleteBan(String token, int subscriptionId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
        .delete('$_baseUrl/api/bans/$subscriptionId', headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  // Event

  static Future listEvents(String token, String groupId, int userId) async {
    var headers = _defaultAuthHeader(token);
    var data = { 'group_id': groupId.toString(), 'user_id': userId.toString() };

    Uri uri = Uri.http(_base, '/api/events/', data);
    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future createEvent(String token, int groupId, int userId, String title, String content, String date) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "group_id": groupId.toString(),
      "user_id": userId.toString(),
      "title": title.toString(),
      "content": content.toString(),
      "date": date.toString()
    };

    var response = await http
      .post('$_baseUrl/api/events', body: json.encode(data), headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  static Future updateEvent(String token, int eventId, String title, String content, String date) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "title": title.toString(),
      "content": content.toString(),
      "date": date.toString()
    };

    var response = await http
      .put('$_baseUrl/api/events/$eventId', body: json.encode(data), headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  static Future deleteEvent(String token, int eventId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
      .delete('$_baseUrl/api/events/$eventId', headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  // Performance

  static Future listPerformances(String token, String disciplineId, String userId) async {
    var headers = _defaultAuthHeader(token);
    var data = { 'discipline_id': disciplineId.toString(), 'user_id': userId.toString() };

    Uri uri = Uri.http(_base, '/api/performances/', data);
    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future createPerformance(String token, int disciplineId, String description, String value, String maxValue) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "discipline_id": disciplineId.toString(),
      "description": description.toString(),
      "value": value.toString(),
      "max_value": maxValue.toString()
    };

    var response = await http
      .post('$_baseUrl/api/performances', body: json.encode(data), headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  static Future updatePerformance(String token, int performanceId, String description, String value, String maxValue) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "description": description.toString(),
      "value": value.toString(),
      "max_value": maxValue.toString()
    };

    var response = await http
      .put('$_baseUrl/api/performances/$performanceId', body: json.encode(data), headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  static Future deletePerformance(String token, int performanceId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
      .delete('$_baseUrl/api/performances/$performanceId', headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  // Post

  static Future listPosts(String token, String groupId, String userId) async {
    var headers = _defaultAuthHeader(token);
    var data = { 'group_id': groupId.toString(), 'user_id': userId.toString() };

    Uri uri = Uri.http(_base, '/api/posts/', data);
    var response = await http.get(uri, headers: headers).catchError((e) {
      print(e);
    });

    return response;
  }

  static Future createPost(String token, int groupId, int userId, String title, String content) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "group_id": groupId.toString(),
      "user_id": userId.toString(),
      "title": title.toString(),
      "content": content.toString()
    };

    var response = await http
      .post('$_baseUrl/api/posts', body: json.encode(data), headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  static Future updatePost(String token, int postId, String title, String content) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "title": title.toString(),
      "content": content.toString()
    };

    var response = await http
      .put('$_baseUrl/api/posts/$postId', body: json.encode(data), headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }

  static Future deletePost(String token, int postId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
      .delete('$_baseUrl/api/posts/$postId', headers: headers)
      .timeout(Duration(seconds: 500))
      .catchError((e) { print(e); });

    return response;
  }
}
