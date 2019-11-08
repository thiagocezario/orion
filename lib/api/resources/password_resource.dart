import '../base.dart';

class PasswordResource {
  static String path() {
    return '/api/passwords';
  }

  static String recoverPath() {
    return '${path()}/recover';
  }

  static String resetPath() {
    return '${path()}/reset';
  }

  static Future recover(String email) async {
    dynamic data = { "email": email };
    return Base.createResource(recoverPath(), data);
  }

  static Future reset(String token, String password) async {
    dynamic data = { "password": password, "reset_password_token": token };
    return Base.createResource(resetPath(), data);
  }
}
