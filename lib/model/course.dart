// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

List<Course> courseFromJson(String str) => new List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
    int id;
    String name;
    int members = 0;

    Course({
        this.id,
        this.name,
        // this.members,
    });

    factory Course.fromJson(Map<String, dynamic> json) => new Course(
        id: json["id"],
        name: json["name"],
        // members: json["members"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "members": members,
    };
}
