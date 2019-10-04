// To parse this JSON data, do
//
//     final subscriptions = subscriptionsFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/group.dart';
import 'package:orion/model/student.dart';

List<Subscriptions> subscriptionsFromJson(String str) => List<Subscriptions>.from(json.decode(str).map((x) => Subscriptions.fromJson(x)));

String subscriptionsToJson(List<Subscriptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subscriptions {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    Student student;
    Group group;

    Subscriptions({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.student,
        this.group,
    });

    factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        student: Student.fromJson(json["student"]),
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "student": student.toJson(),
        "group": group == null ? null : group.toJson(),
    };
}
