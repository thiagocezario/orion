// To parse this JSON data, do
//
//     final discipline = disciplineFromJson(jsonString);

import 'dart:convert';

import 'metadata.dart';

List<Discipline> disciplineFromJson(String str) => new List<Discipline>.from(json.decode(str).map((x) => Discipline.fromJson(x)));

String disciplineToJson(List<Discipline> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Discipline {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    Metadata metadata;

    Discipline({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.metadata
    });

    factory Discipline.fromJson(Map<String, dynamic> json) => new Discipline(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        metadata: json["metadata"] == null ? Metadata(subscriptions: 0) : Metadata.fromJson(json["metadata"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "metadata": metadata == null ? null : metadata.toJson(),
    };
}
