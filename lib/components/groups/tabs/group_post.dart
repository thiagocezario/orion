import 'package:flutter/material.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/commom_items/material_button.dart';
import 'package:orion/components/posts/post_dialog.dart';
import 'package:orion/components/posts/post_item.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/post.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:provider/provider.dart';

class GroupPost extends StatefulWidget {
  final Group group;

  GroupPost(this.group);

  @override
  _GroupPostState createState() => _GroupPostState(group);
}

class _GroupPostState extends State<GroupPost> {
  final Group group;

  _GroupPostState(this.group);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupPostsProvider>(
        builder: (context, groupPostsProvider, _) {
      return Stack(
        children: <Widget>[
          ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                height: 15,
                thickness: 5,
              );
            },
            itemCount: groupPostsProvider.groupPosts.length,
            itemBuilder: (context, index) {
              Post post = groupPostsProvider.groupPosts[index];

              return PostItem(
                key: UniqueKey(),
                post: post,
                group: group,
              );
            },
          ),
        ],
      );
    });
  }
}
