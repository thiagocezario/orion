// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/discipline.dart';
import 'package:orion/model/institution.dart';

import 'course.dart';
import 'metadata.dart';

List<Group> groupFromJson(String str) => List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Group {
    int id;
    String name;
    String description;
    int colleagues;
    DateTime createdAt;
    DateTime updatedAt;
    Metadata metadata;
    Institution institution;
    Course course;
    Discipline discipline;
    bool isPrivate;
    String year;

    Group({
        this.id,
        this.name,
        this.description,
        this.colleagues,
        this.createdAt,
        this.updatedAt,
        this.metadata,
        this.institution,
        this.course,
        this.discipline,
        this.isPrivate,
        this.year,
    });

    String link() {
      return 'http://www.orionapp/subscribe?id=$id';
    }

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"] == null ? "" : json["name"],
        description: json["description"] == null ? "" : json["description"],
        colleagues: json["colleagues"] == null ? 0 : json["colleagues"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        institution: json["institution"] == null ? Institution() : Institution.fromJson(json["institution"]),
        course: json["course"] == null ? Course() : Course.fromJson(json["course"]),
        discipline: json["discipline"] == null ? Discipline() : Discipline.fromJson(json["discipline"]),
        isPrivate: json["private"] ?? false,
        year: json["year"].toString() ?? DateTime.now().year.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "metadata": metadata.toJson(),
        "institution": institution.toJson(),
        "course": course.toJson(),
        "discipline": discipline.toJson(),
        "private_group": isPrivate,
        "year": year,
    };
}