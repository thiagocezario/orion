import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/password_resource.dart';
import 'package:orion/pages/login/reset_password_page.dart';

void openReset(BuildContext context, Uri uri) {
  if (uri == null || uri.path != '/reset') {
    return;
  }

  String token = uri.queryParameters['token'];

  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPasswordPage(token: token)))
      .then((password) {
    PasswordResource.reset(token, password).then((response) {});
  });
}
