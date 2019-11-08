import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:orion/model/user.dart';

class Base {
  final HttpClient client = new HttpClient();

  static final _scheme = 'http';
  static final int _port = 3000;

  // static final String _ip = "10.0.2.2";    // Local Android
  // static final String _ip = "localhost";   // Local IOS
  // static final String _ip = "192.168.15.3"; // External access
  static final String _ip = "192.168.0.4"; // External access
  // (run server with rails server -b (YOUR IP) -p 3000)

  static Uri collectionPath(String path) {
    return Uri(scheme: _scheme, host: _ip, port: _port, path: path);
  }

  static Uri memberPath(String path, String resourceId) {
    String memberPath = '$path/$resourceId';
    return Uri(scheme: _scheme, host: _ip, port: _port, path: memberPath);
  }

  static Map<String, String> _defaultHeader() {
    return {'Content-Type': 'application/json; charset=UTF-8'};
  }

  static Map<String, String> defaultAuthHeader() {
    String token = Singleton().jwtToken;

    return {}
      ..addAll(_defaultHeader())
      ..addAll({'Authorization': 'Bearer $token'});
  }

  static handleError(dynamic e) {
    print('Request error');
    print(e);
  }

  static Duration defaultTimeout() {
    return Duration(seconds: 500);
  }

  static Future listResources(String path, dynamic data) async {
    Map<String, String> headers = defaultAuthHeader();
    Uri uri = Uri(
        scheme: _scheme,
        host: _ip,
        port: _port,
        path: path,
        queryParameters: data);

    return http
        .get(uri, headers: headers)
        .timeout(defaultTimeout())
        .catchError(handleError);
  }

  static Future findResource(String path, String resourceId) async {
    Map<String, String> headers = defaultAuthHeader();
    Uri uri = memberPath(path, resourceId);

    return http
        .get(uri, headers: headers)
        .timeout(defaultTimeout())
        .catchError(handleError);
  }

  static Future createResource(String path, dynamic data) async {
    Uri uri = collectionPath(path);
    var headers = defaultAuthHeader();
    dynamic body = json.encode(data);

    return http
        .post(uri, body: body, headers: headers)
        .timeout(defaultTimeout())
        .catchError(handleError);
  }

  static Future updateResource(
      String path, String resourceId, dynamic data) async {
    Uri uri = memberPath(path, resourceId);
    var headers = defaultAuthHeader();
    dynamic body = json.encode(data);

    return http
        .put(uri, body: body, headers: headers)
        .timeout(defaultTimeout())
        .catchError(handleError);
  }

  static Future deleteResource(String path, String resourceId) async {
    Uri uri = memberPath(path, resourceId);
    var headers = defaultAuthHeader();

    return http
        .delete(uri, headers: headers)
        .timeout(defaultTimeout())
        .catchError(handleError);
  }
}
