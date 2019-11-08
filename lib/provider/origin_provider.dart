import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class OriginProvider extends ChangeNotifier {
  StreamSubscription _sub;
  Uri _uri;
  bool _opend = false;

  get uri => _uri;
  get opend => _opend;

  void init() {
    if(_sub != null) { return; }

    _sub = getUriLinksStream().listen(
      handleOriginUpdate,
      onError: handleError,
    );
  }

  void open() {
    _opend = true;
  }

  void handleOriginUpdate(Uri uri) {
    print('Here');
    print('uri: $uri');
    _uri = uri;
    _opend = false;
    notifyListeners();
  }

  void handleError(dynamic err) {
    print('Errors...');

    // notifyListeners();
  }
}
