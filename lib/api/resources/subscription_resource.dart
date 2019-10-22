import 'package:orion/model/subscriptions.dart';

import '../base.dart';

class SubscriptionResource {
  static String path() {
    return '/api/subscriptions';
  }

  static Future list(dynamic data) async {
    return Base.listResources(path(), data);
  }

  static Future create(dynamic data) async {
    return Base.createResource(path(), data);
  }

  static Future update(String resourceId, dynamic data) async {
    return Base.updateResource(path(), resourceId, data);
  }

  static Future delete(String resourceId) async {
    return Base.deleteResource(path(), resourceId);
  }

  static Future createObject(Subscription subscription) async {
    var data = {"group_id": subscription.group.id.toString()};
    return create(data);
  }

  static Future subscribe(String groupId) async {
    var data = {"group_id": groupId};
    return create(data);
  }

  static Future unsubscribe(String resourceId) async {
    return delete(resourceId);
  }
}
