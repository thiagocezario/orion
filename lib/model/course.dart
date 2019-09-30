// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/metadata.dart';

List<Course> courseFromJson(String str) => new List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    Metadata metadata;

    Course({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.metadata
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        metadata: Metadata.fromJson(json["metadata"])
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "metadata": metadata.toJson()
    };
}