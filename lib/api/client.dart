import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:orion/model/blob.dart';
import 'package:orion/model/user.dart';

import 'package:http/http.dart' as http;

import 'base.dart';

class Client {
  // change if you aew running on android emulator
  // static final String _base = "10.0.2.2:3000";

  // static final String _base = 'localhost:3000';

  final HttpClient client = new HttpClient();

  static final String _ip = "192.168.15.4";
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

  static Future signIn(User user) async {
    var headers = _defaultHeader();
    var data = {'email': user.email, 'password': user.password};

    var uri =
        Uri(scheme: 'http', host: _ip, path: '/api/sessions/', port: _port);
    print(uri.toString());
    var client = http.Client();

    var response = await client
        .post(uri, body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
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

    var uri =
        Uri(scheme: 'http', host: _ip, path: '/api/students/', port: _port);
    var response = await http
        .post(uri, body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
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

  // Performance
  static Future createPerformance(String token, int disciplineId,
      String description, String value, String maxValue) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "discipline_id": disciplineId.toString(),
      "description": description.toString(),
      "value": value.toString(),
      "max_value": maxValue.toString()
    };

    var response = await http
        .post('$_baseUrl/api/performances',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future updatePerformance(String token, int performanceId,
      String description, String value, String maxValue) async {
    var headers = _defaultAuthHeader(token);
    var data = {
      "description": description.toString(),
      "value": value.toString(),
      "max_value": maxValue.toString()
    };

    var response = await http
        .put('$_baseUrl/api/performances/$performanceId',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  static Future deletePerformance(String token, int performanceId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
        .delete('$_baseUrl/api/performances/$performanceId', headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }

  // Post
  static Future updatePost(String token, int postId, String title,
      String content, List<Blob> blobs) async {
    var uri =
        Uri(scheme: 'http', host: _ip, path: '/api/posts/$postId', port: _port);

    if (blobs == null) {
      blobs = List();
    }

    List<Blob> blobsToUpload = List();
    blobs.where((Blob blob) {
      return blob !=null && blob.id == null;
    }).forEach((Blob blob) {
      blobsToUpload.add(blob);
    });

    var request = new http.MultipartRequest("PUT", uri);

    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.fields['post[title]'] = title.toString();
    request.fields['post[content]'] = content.toString();

    // blobsToUpload.forEach((Blob blob) {
    Blob blob = blobsToUpload.first;

    if (blob.id == null) {
      request.files.add(await MultipartFile.fromPath(
        'post[files][]',
        blob.file.path,
      ));
    }
    // });

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  static Future updatePost2(
      String token, int postId, String title, String content) async {
    var headers = _defaultAuthHeader(token);
    var data = {"title": title.toString(), "content": content.toString()};

    var response = await http
        .put('$_baseUrl/api/posts/$postId',
            body: json.encode(data), headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }



  static Future deletePost(String token, int postId) async {
    var headers = _defaultAuthHeader(token);

    var response = await http
        .delete('$_baseUrl/api/posts/$postId', headers: headers)
        .timeout(Duration(seconds: 500))
        .catchError((e) {
      print(e);
    });

    return response;
  }
}
