// To parse this JSON data, do
//
//     final institution = institutionFromJson(jsonString);

import 'dart:convert';

import 'metadata.dart';

List<Institution> institutionFromJson(String str) => new List<Institution>.from(json.decode(str).map((x) => Institution.fromJson(x)));

String institutionToJson(List<Institution> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Institution {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    Metadata metadata;

    Institution({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.metadata
    });

    factory Institution.fromJson(Map<String, dynamic> json) => Institution(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "metadata": metadata == null ? null : metadata.toJson(),
    };
}