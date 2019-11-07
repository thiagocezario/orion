import 'package:flutter/material.dart';
import 'package:orion/model/post.dart';

class GroupPreviewPosts extends StatelessWidget {
  final List<Post> posts;

  GroupPreviewPosts(this.posts);

  @override
  Widget build(BuildContext context) {
    if (posts.length == 0) {
      return SliverToBoxAdapter(
        child: ListTile(
          title: Text(
            'Não existem publicações feitas neste grupo.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: <Widget>[
              Text(".. x stars"),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  size: 25,
                ),
                title: Text(posts[index].title),
                subtitle: Text(
                  posts[index].content,
                ),
              ),
              Text("Attachments: ${posts[index].blobs.length}"),
              Divider(),
            ],
          );
        },
        childCount: posts.length > 3 ? 3 : posts.length,
      ),
    );
  }
}
