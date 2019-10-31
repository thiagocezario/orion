import 'package:orion/model/post_classification.dart';

import '../base.dart';

class PostClassificationResource {
  static String path(String postId) {
    return '/api/posts/$postId/classifications';
  }

  static Future create(String postId, dynamic data) async {
    return Base.createResource(path(postId), data);
  }

  static Future delete(String postId) async {
    return Base.deleteResource(path(postId), postId);
  }

  static Future createObject(PostClassification classification) async {
    dynamic data = {"like": classification.like};

    return create(classification.post.id.toString(), data);
  }

  static Future deleteObject(PostClassification classification) async {
    return delete(classification.post.id.toString());
  }
}
