import 'package:flutter/widgets.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/model/post.dart';

class GroupPostsProvider with ChangeNotifier {
  List<Post> _groupPosts = List();

  get groupPosts => _groupPosts;

  void fetchPosts(String groupId) async {
    var data = { 'group_id': groupId };
    await PostResource.list(data).then(handleResponse);
  }

  void removePost(Post post){
    _groupPosts.removeWhere((Post i) { return i.id == post.id; });
    notifyListeners();
  }

  void handleResponse(dynamic response) {
    _groupPosts = postFromJson(response.body);
    notifyListeners();
  }
}