// To parse this JSON data, do
//
//     final subscriptions = subscriptionsFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/group.dart';
import 'package:orion/model/student.dart';

List<Subscription> subscriptionFromJson(String str) => List<Subscription>.from(json.decode(str).map((x) => Subscription.fromJson(x)));

String subscriptionToJson(List<Subscription> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subscription {
    int id;
    bool active;
    bool manager;
    bool banned;
    DateTime createdAt;
    DateTime updatedAt;
    Student student;
    Group group;

    Subscription({
        this.id,
        this.active,
        this.manager,
        this.banned,
        this.createdAt,
        this.updatedAt,
        this.student,
        this.group,
    });

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"] == null ? null : json["id"],
        active: json["active"],
        manager: json["manager"],
        banned: json["banned"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        student: json["student"] == null ? null : Student.fromJson(json["student"]),
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "manager": manager,
        "banned": banned,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "student": student.toJson(),
        "group": group == null ? null : group.toJson(),
    };
}