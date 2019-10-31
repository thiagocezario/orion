// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

import 'post.dart';

List<PostClassification> eventFromJson(String str) => new List<PostClassification>.from(json.decode(str).map((x) => PostClassification.fromJson(x)));

String eventToJson(List<PostClassification> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class PostClassification {
    int id;
    bool like;
    Post post = Post();

    PostClassification({
        this.id,
        this.like = false,
        this.post,
    });

    factory PostClassification.fromJson(Map<String, dynamic> json) => PostClassification(
        id: json["id"],
        like: json["like"]
    );

    Map<String, dynamic> toJson() => {
        "like": like
    };
}