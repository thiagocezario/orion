import 'package:flutter/material.dart';
import 'package:orion/components/empty_warning.dart';
import 'package:orion/components/groups/tabs/tab_title.dart';
import 'package:orion/components/posts/post_item.dart';
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

  Widget postsList(GroupPostsProvider groupPostsProvider) {
    int length = groupPostsProvider.groupPosts.length;
    if (length == 0) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          child: EmptyWarning(
              messsage: 'Este grupo ainda não possui posts registrados!'),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            key: UniqueKey(),
            children: <Widget>[
              PostItem(
                UniqueKey(),
                groupPostsProvider.groupPosts[index],
                group,
                false,
              ),
              Divider(
                height: 5,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
            ],
          );
        },
        childCount: groupPostsProvider.groupPosts.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupPostsProvider>(
      builder: (context, groupPostsProvider, _) {
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: TabTitle(title: 'Posts'),
            ),
            postsList(groupPostsProvider),
          ],
        );
      },
    );
  }
}
