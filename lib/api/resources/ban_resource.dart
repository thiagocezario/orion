import 'package:orion/model/subscriptions.dart';

import '../base.dart';

class BanResource {
  static String path() {
    return '/api/bans';
  }

  static Future create(dynamic data) async {
    return Base.createResource(path(), data);
  }

  static Future delete(String resourceId) async {
    return Base.deleteResource(path(), resourceId);
  }

  static Future createObject(Subscription subscription) async {
    var data = {"subscription_id": subscription.id.toString()};
    return create(data);
  }

  static Future deleteObject(Subscription subscription) async {
    return delete(subscription.id.toString());
  }
}
