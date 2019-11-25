import 'package:flutter/material.dart';
import 'package:orion/components/empty_warning.dart';
import 'package:orion/components/posts/post_item.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/post.dart';

class GroupPreviewPosts extends StatelessWidget {
  final List<Post> posts;
  final Group group;

  GroupPreviewPosts(this.posts, this.group);

  @override
  Widget build(BuildContext context) {
    if (posts.length == 0) {
      return SliverToBoxAdapter(
        child: ListTile(
          title: EmptyWarning(
            messsage: 'Não existem publicações feitas neste grupo.',
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: <Widget>[
              PostItem(
                UniqueKey(),
                posts[index],
                group,
                true,
              ),
              Divider()
            ],
          );
        },
        childCount: posts.length > 3 ? 3 : posts.length,
      ),
    );
  }
}
