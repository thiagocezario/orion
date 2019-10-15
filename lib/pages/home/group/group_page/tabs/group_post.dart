import 'package:flutter/material.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/posts/post_cards.dart';
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
      await Client.updatePost(
              Singleton().jwtToken, result.id, result.title, result.content)
          .then((response) {
        Provider.of<GroupPostsProvider>(context)
            .fetchPosts(result.group.id.toString());
      });
    }
  }

  Future _createPost() async {
    Post result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return GroupPostDialog(null, group);
      },
      fullscreenDialog: true,
    ));

    if (result != null) {
      await Client.createPost(Singleton().jwtToken, group.id,
              Singleton().user.id, result.title, result.content)
          .then((response) {
        Provider.of<GroupPostsProvider>(context)
            .fetchPosts(group.id.toString());
      });
    }
  }

  Future _popUpMenuActions(String action, Post post) async {
    if (action == 'Editar') {
      await _editPost(post);
    } else if (action == 'Deletar') {
      await Client.deletePost(Singleton().jwtToken, post.id).then((response) {
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
                return OutlineButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Adicionar nova publicação',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
                  onPressed: () async => await _createPost(),
                );
              }
              return ListTile(
                leading: Icon(
                  Icons.access_time,
                  size: 25,
                ),
                title: Text(groupPostsProvider.groupPosts[index - 1].title),
                subtitle: Text(
                  groupPostsProvider.groupPosts[index - 1].content,
                ),
                trailing:
                    eventActions(groupPostsProvider.groupPosts[index - 1]),
              );
            },
          ),
        ],
      ),
    );
  }
}
