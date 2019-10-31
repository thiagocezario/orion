// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:orion/model/post_classification.dart';
import 'package:orion/model/user.dart';

import 'blob.dart';
import 'group.dart';

List<Post> postFromJson(String str) =>
    new List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  int id;
  int likeCount;
  int unlikeCount;
  String title;
  String content;
  Group group;
  User student;
  PostClassification classification;
  List<Blob> blobs = List();
  DateTime createdAt;
  DateTime updatedAt;

  Post({
    this.id,
    this.likeCount = 0,
    this.unlikeCount = 0,
    this.title,
    this.content,
    this.group,
    this.student,
    this.blobs,
    this.classification,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        likeCount: json["like_count"],
        unlikeCount: json["unlike_count"],
        title: json["title"],
        content: json["content"],
        // group: Group(id: json["group"]["id"], name: json["group"]["name"]),
        student: User.fromJson(json["student"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        classification:
            json["classification"] == null || json["classification"] == "null"
                ? PostClassification()
                : PostClassification.fromJson(json["classification"]),
        blobs: (json['files'] as List).map((blobParams) {
          return Blob.fromJson(blobParams);
        }).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "group_id": group == null ? null : group.id,
        "user_id": student == null ? null : student.id,
      };
}
