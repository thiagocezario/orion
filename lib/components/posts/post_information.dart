import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orion/components/blobs/blob_item.dart';
import 'package:orion/components/posts/post_item.dart';
import 'package:orion/model/blob.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/post.dart';

class PostInformation extends StatelessWidget {
  final Post post;

  PostInformation(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(post.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: Text(post.student.name),
            subtitle: Text(DateFormat('dd/MM/yyyy H:m').format(post.createdAt)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Text(
              post.content,
              style: TextStyle(
                fontSize: 18,
              ),
              softWrap: true,
            ),
          ),
          PostRating(post, false),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              'Anexos',
              style: titleStyle,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30.0),
            height: MediaQuery.of(context).size.height * 0.50,
            child: Scrollbar(
              child: ListView.separated(
                itemCount: post.blobs != null ? post.blobs.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  Blob blob = post.blobs[index];
                  return BlobItemPreview(blob);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
