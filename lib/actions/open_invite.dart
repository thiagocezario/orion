import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/group_resource.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/group/group_preview_page.dart';

void openInvite(BuildContext context, Uri uri) {
  if (uri == null || uri.path != '/subscribe') {
    return;
  }

  String id = uri.queryParameters['id'];

  GroupResource.find(id).then((response) {
    Group group = Group.fromJson(json.decode(response.body));

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GroupPreviewPage(group)));
  });
}
