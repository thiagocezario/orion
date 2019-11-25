import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/model/post.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:provider/provider.dart';

class PostController {
  static refresh(context, {group}) {
    Provider.of<GroupPostsProvider>(context).fetchPosts(group.id.toString());
  }

  static create(context, {Post post}) {
    PostResource.createObject(post).then(
      (response) {
        refresh(context, group: post.group);
      },
    );
  }

  static update(context, {Post post}) {
    PostResource.updateObject(post).then(
      (response) {
        refresh(context, group: post.group);
      },
    );
  }

  static remove(context, {Post post}) {
    PostResource.delete(post.id.toString()).then(
      (response) {
        Provider.of<GroupPostsProvider>(context).removePost(post);
      },
    );
  }
}
