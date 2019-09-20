// To parse this JSON data, do
//
//     final discipline = disciplineFromJson(jsonString);

import 'dart:convert';

List<Discipline> disciplineFromJson(String str) => new List<Discipline>.from(json.decode(str).map((x) => Discipline.fromJson(x)));

String disciplineToJson(List<Discipline> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Discipline {
    int id;
    String name;
    int members = 0;

    Discipline({
        this.id,
        this.name,
        // this.members,
    });

    factory Discipline.fromJson(Map<String, dynamic> json) => new Discipline(
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
