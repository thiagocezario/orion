import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/model/post.dart';
import 'package:orion/model/user.dart';

class GroupPostsProvider with ChangeNotifier {
  List<Post> _groupPosts = List();

  get groupPosts => _groupPosts;

  void fetchPosts(String groupId) async {
    await Client.listPosts(Singleton().jwtToken, groupId, '').then((response) {
      _groupPosts = postFromJson(response.body);
      notifyListeners();
    });
  }
}