import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/actions/origin.dart';
import 'package:orion/pages/group/group_preview_page.dart';

Future openInvite(BuildContext context) {
  return initUniLinks().then((response) {
    if (response == null) {
      return;
    }

    Uri uri = response;
    String id = uri.queryParameters['id'];

    // Open preview when user commig from external link
    // Verify path in the future

    GroupResource.find(id).then((response) {
      Group group = Group.fromJson(json.decode(response.body));

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => GroupPreviewPage(group)));
    });
  });
}
