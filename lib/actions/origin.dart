import 'dart:async';

import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

Future<dynamic> initUniLinks() async {

  try {
    return getInitialUri();
  } on PlatformException {
    return null;
  }
}

