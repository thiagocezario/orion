// To parse this JSON data, do
//
//     final institution = institutionFromJson(jsonString);

import 'dart:convert';

List<Institution> institutionFromJson(String str) => new List<Institution>.from(json.decode(str).map((x) => Institution.fromJson(x)));

String institutionToJson(List<Institution> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Institution {
    int id;
    String name;
    int members;

    Institution({
        this.id,
        this.name,
        this.members,
    });

    factory Institution.fromJson(Map<String, dynamic> json) => new Institution(
        id: json["id"],
        name: json["name"],
        members: json["members"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "members": members,
    };
}
