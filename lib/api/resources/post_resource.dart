import 'package:orion/model/blob.dart';
import 'package:orion/model/post.dart';
import 'package:http/http.dart' as http;

import '../base.dart';

class PostResource {
  static String path() {
    return '/api/posts';
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

  static Future createObject(Post post) async {
    Uri uri = Base.collectionPath(path());

    dynamic data = {
      'post[group_id]': post.group.id.toString(),
      'post[user_id]': post.student.id.toString(),
      'post[title]': post.title,
      'post[content]': post.content
    };

    List<Blob> blobsToUpload = List();
    post.blobs.where((Blob blob) {
      return blob.id == null;
    }).forEach((Blob blob) {
      blobsToUpload.add(blob);
    });

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(Base.defaultAuthHeader());
    request.fields.addAll(data);

    // blobsToUpload.forEach((Blob blob) {
    Blob blob = blobsToUpload.first;
    request.files.add(await http.MultipartFile.fromPath(
      'post[files][]',
      blob.file.path,
    ));
    // });

    return request.send();
  }

  static Future updateObject(Post post) async {
    var data = {}; // get data from object
    return update(post.id.toString(), data);
  }
}
