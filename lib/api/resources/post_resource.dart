import 'package:http/http.dart';
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
    if(post.blobs == null) { post.blobs = List(); }
    post.blobs.where((Blob blob) {
      return blob.id == null && !blob.toRemove;
    }).forEach((Blob blob) {
      blobsToUpload.add(blob);
    });

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(Base.defaultAuthHeader());
    request.fields.addAll(data);

    List.generate(blobsToUpload.length, (index) {
      Blob blob = blobsToUpload[index];
      List<int> bytes = blob.file.readAsBytesSync();

      if (blob != null) {
        MultipartFile multipartFile = MultipartFile.fromBytes(
            'post[files][]', bytes,
            filename: blob.filename);

        request.files.add(multipartFile);
      }
    });

    return request.send();
  }

  static Future updateObject(Post post) async {
    Uri uri = Base.memberPath(path(), post.id.toString());

    dynamic data = {'post[title]': post.title, 'post[content]': post.content};

    List<Blob> blobsToUpload = List();
    post.blobs.where((Blob blob) {
      return blob.id == null && !blob.toRemove;
    }).forEach((Blob blob) {
      blobsToUpload.add(blob);
    });

    List<String> blobsToRemove = List();
    post.blobs.where((Blob blob) {
      return blob.id != null && blob.toRemove;
    }).forEach((Blob blob) {
      blobsToRemove.add(blob.id.toString());
    });

    var request = new http.MultipartRequest("PUT", uri);
    request.headers.addAll(Base.defaultAuthHeader());
    request.fields.addAll(data);

    List.generate(blobsToUpload.length, (index) {
      Blob blob = blobsToUpload[index];
      List<int> bytes = blob.file.readAsBytesSync();

      if (blob != null) {
        MultipartFile multipartFile = MultipartFile.fromBytes(
            'post[files][]', bytes,
            filename: blob.filename);

        request.files.add(multipartFile);
      }
    });

    blobsToRemove.forEach((id) {
      request.fields['post[files_to_remove][$id]'] = id;
    });

    return request.send();
  }
}
