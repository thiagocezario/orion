// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/user.dart';

import 'group.dart';

List<Event> eventFromJson(String str) => new List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    int id;
    String title = "";
    String content = "";
    Group group = Group();
    User student = User();
    DateTime date = DateTime.now();

    Event({
        this.id,
        this.title,
        this.content,
        this.group,
        this.student,
        this.date,
    });

    String description(){
      return this.group.name.toString(); // group.name;
    }

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        // group requires institution and group data
        // but that information is not necessary here
        group: Group(id: json["group"]["id"], name: json["group"]["name"]),
        student: User.fromJson(json["student"]),
        date: DateTime.parse(json["date"])
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "group": group.toJson(),
        "student": student.toJson(),
        "date": date.toIso8601String(),
        // not complete yet
    };
}