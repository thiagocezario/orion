import 'package:flutter/material.dart';
import 'package:orion/components/posts/post_cards.dart';
import 'package:orion/model/group.dart';
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
      builder: (context, groupPostsProvider, _) => Container(
        alignment: Alignment.center,
        child: PostCards().getPostCards(context, groupPostsProvider.groupPosts),
      ),
    );
  }
}
