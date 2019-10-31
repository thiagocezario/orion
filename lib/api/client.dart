import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Client {
  // static final String _ip = "10.0.2.2";    // Local Android
  // static final String _ip = "localhost";   // Local IOS
  static final String _ip = "192.168.15.3"; // External access
  // (run server with rails server -b (YOUR IP) -p 3000)

  final HttpClient client = new HttpClient();

  static final int _port = 3000;

  static final String _base = "$_ip:$_port";

  static final String _baseUrl = 'http://$_base';

  static Map<String, String> _defaultHeader() {
    return {'Content-Type': 'application/json; charset=UTF-8'};
  }

  static Map<String, String> _defaultAuthHeader(String token) {
    return {}
      ..addAll(_defaultHeader())
      ..addAll({'Authorization': 'Bearer $token'});
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
}
