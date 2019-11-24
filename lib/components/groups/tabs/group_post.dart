import 'package:flutter/material.dart';
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
            SliverList(
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
            )
          ],
        );
      },
    );
  }
}

  // SliverAppBar(
  //   backgroundColor: darkGreyColor,
  //   pinned: true,
  //   automaticallyImplyLeading: false,
  //   title: PreferredSize(
  //     preferredSize: Size.fromHeight(300.0), // here the desired height
  //     child: Container(height: 300,),
  //   ),
  //   actions: <Widget>[
  //     IconButton(
  //       icon: Icon(Icons.add),
  //       onPressed: () {},
  //     )
  //   ],
  // ),