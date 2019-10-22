import 'package:orion/model/user.dart';

import '../base.dart';

class SessionResource {
  static String path() {
    return '/api/sessions';
  }

  static Future create(dynamic data) async {
    return Base.createResource(path(), data);
  }

  static Future delete(String resourceId) async {
    return Base.deleteResource(path(), resourceId);
  }

  static Future signIn(dynamic data) async {
    return create(data);
  }

  static Future signInObject(User student) async {
    var data = {'email': student.email, 'password': student.password};
    return create(data);
  }
}
