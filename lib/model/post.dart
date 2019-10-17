// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:orion/model/user.dart';

import 'group.dart';

List<Post> postFromJson(String str) => new List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    int id;
    String title;
    String content;
    Group group;
    User student;
    List<File> attachments = List();

    Post({
        this.id,
        this.title,
        this.content,
        this.group,
        this.student
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        // group: Group(id: json["group"]["id"], name: json["group"]["name"]),
        student: User.fromJson(json["student"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "group_id": group == null ? null : group.id,
        "user_id": student == null ? null : student.id,
    };
}