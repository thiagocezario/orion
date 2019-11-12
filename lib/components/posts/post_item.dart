import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/api/resources/post_classification_resource.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/components/posts/post_dialog.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/post.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/group_posts_provider.dart';
import 'package:provider/provider.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final Group group;

  PostItem({Key key, this.post, this.group}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState(post, group);
}

class _PostItemState extends State<PostItem> {
  Post post;
  Group group;

  bool liked = false;
  bool unliked = false;

  _PostItemState(this.post, this.group) {
    if (post.classification.id != null) {
      liked = post.classification.like;
      unliked = !liked;
    } else {
      liked = false;
      unliked = false;
    }
  }

  void likePost() {
    setState(() {
      liked = !liked;
      if (unliked) {
        unliked = false;
        post.unlikeCount--;
      }
      post.likeCount += liked ? 1 : -1;

      updateObject();
    });
  }

  void unlikePost() {
    setState(() {
      unliked = !unliked;
      if (liked) {
        liked = false;
        post.likeCount--;
      }
      post.unlikeCount += unliked ? 1 : -1;

      updateObject();
    });
  }

  void updateObject() {
    bool remove = !unliked && !liked;
    post.classification.like = liked;
    post.classification.post = post;

    if (remove) {
      if (post.classification.id == null) {
        return;
      }
      PostClassificationResource.deleteObject(post.classification);
    } else {
      PostClassificationResource.createObject(post.classification)
          .then((response) {});
    }
  }

  Color likeColor() {
    return liked ? Colors.blueAccent : Colors.grey;
  }

  Color unlikeColor() {
    return unliked ? Colors.blueAccent : Colors.grey;
  }

  Icon likeIcon() {
    return Icon(
      Icons.thumb_up,
      color: likeColor(),
      size: 18,
    );
  }

  Icon unlikeIcon() {
    return Icon(
      Icons.thumb_down,
      color: unlikeColor(),
      size: 18,
    );
  }

  InkWell rateButton({onTap, icon, count}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: icon,
            ),
            Text(count.toString()),
          ],
        ),
      ),
    );
  }

  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Editar', 'Deletar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();

  Future _popUpMenuActions(String action, Post post) async {
    if (action == 'Editar') {
      await _editPost(post);
    } else if (action == 'Deletar') {
      await PostResource.delete(post.id.toString()).then((response) {
        Provider.of<GroupPostsProvider>(context).removePost(post);
      });
    }
  }

  Future _editPost(Post post) async {
    GroupPostsProvider provider = Provider.of<GroupPostsProvider>(context);

    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) {
        return GroupPostDialog(post, group);
      },
      fullscreenDialog: true,
    ))
        .then((resultPost) {
      if (resultPost != null) {
        PostResource.updateObject(resultPost).then((response) {
          provider.fetchPosts(group.id.toString());
        });
      }
    });
  }

  PopupMenuButton<String> eventActions(Post post) {
    if (post.student.id == Singleton().user.id) {
      return PopupMenuButton<String>(
        onSelected: (String actionSelected) =>
            _popUpMenuActions(actionSelected, post),
        itemBuilder: (BuildContext context) => _popUpMenuItems,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(post.student.name),
              subtitle:
                  Text(DateFormat('dd/MM/yyyy H:m').format(post.createdAt)),
              trailing: eventActions(post),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Text(
                post.content,
                style: TextStyle(fontSize: 18),
                maxLines: 3,
                overflow: TextOverflow.fade,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.attach_file,
                      size: 18,
                    ),
                    Text(post.blobs.length.toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    rateButton(
                        onTap: unlikePost,
                        icon: unlikeIcon(),
                        count: post.unlikeCount),
                    rateButton(
                        onTap: likePost,
                        icon: likeIcon(),
                        count: post.likeCount),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
