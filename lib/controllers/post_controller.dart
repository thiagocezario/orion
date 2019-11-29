import 'package:flutter/material.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/model/post.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:provider/provider.dart';

class PostController {
  GroupPostsProvider groupPostsProvider;

  setProviders(BuildContext context) {
    groupPostsProvider = Provider.of<GroupPostsProvider>(context);
  }

  refresh({group}) {
    groupPostsProvider.fetchPosts(group.id.toString());
  }

  create(context, {Post post}) {
    setProviders(context);

    PostResource.createObject(post).then(
      (response) {
        refresh(group: post.group);
      },
    );
  }

  update(context, {Post post}) {
    setProviders(context);

    PostResource.updateObject(post).then(
      (response) {
        refresh(group: post.group);
      },
    );
  }

  remove(context, {Post post}) {
    setProviders(context);

    PostResource.delete(post.id.toString()).then(
      (response) {
        Provider.of<GroupPostsProvider>(context).removePost(post);
      },
    );
  }
}
