import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/api/resources/post_resource.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/posts/post_dialog.dart';
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
  final List<PopupMenuItem<String>> _popUpMenuItems =
      <String>['Editar', 'Deletar']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList();

  Future _editPost(Post post) async {
    Post result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return GroupPostDialog(post, group);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      print('Lalala: ${result.blobs.length}');

      await PostResource.updateObject(result).then((response) {
        Provider.of<GroupPostsProvider>(context)
            .fetchPosts(group.id.toString());
      });
    }
  }

  Future _createPost() async {
    Post result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return GroupPostDialog(Post(), group);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      result.group = group;
      result.student = Singleton().user;

      await PostResource.createObject(result).then((response) {
        Provider.of<GroupPostsProvider>(context)
            .fetchPosts(group.id.toString());
      });
    }
  }

  Future _popUpMenuActions(String action, Post post) async {
    if (action == 'Editar') {
      await _editPost(post);
    } else if (action == 'Deletar') {
      await PostResource.delete(post.id.toString()).then((response) {
        Provider.of<GroupPostsProvider>(context)
            .fetchPosts(group.id.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

    return Consumer<GroupPostsProvider>(
      builder: (context, groupPostsProvider, _) => Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: groupPostsProvider.groupPosts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: primaryButtonColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      elevation: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Nova publicação',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () async => await _createPost(),
                    ),
                  ),
                );
              }

              Post post = groupPostsProvider.groupPosts[index - 1];
              return Column(
                children: <Widget>[
                  Text(".. x stars"),
                  ListTile(
                    leading: Icon(
                      Icons.access_time,
                      size: 25,
                    ),
                    title: Text(post.title),
                    subtitle: Text(
                      post.content,
                    ),
                    trailing: eventActions(post),
                  ),
                  Text("Attachments: ${post.blobs.length}"),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
