import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/model/post.dart';

class PostCards {
  ListView getPostCards(BuildContext context, List<Post> posts) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(posts[index]);
      },
    );
  }

  IconButton postActions(Post post) {
    if (post.student.id == 2) {
      return IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      );
    }

    return null;
  }

  Widget _buildPostCard(Post post) {
    ListTile card = ListTile(
      title: Text(post.blobs.length.toString()),
      subtitle: Text(post.content),
      trailing: postActions(post),
      isThreeLine: true,
    );

    return Material(
      child: InkWell(
        onTap: () {},
        child: card,
      ),
    );
  }
}
