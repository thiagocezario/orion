// To parse this JSON data, do
//
//     final performance = performanceFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/user.dart';

import 'discipline.dart';

List<Performance> performanceFromJson(String str) => new List<Performance>.from(json.decode(str).map((x) => Performance.fromJson(x)));

String performanceToJson(List<Performance> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Performance {
    int id;
    String description;
    String value;
    String maxValue;
    String percentage;
    Discipline discipline;
    User student;

    Performance({
        this.id,
        this.description,
        this.value,
        this.maxValue,
        this.percentage,
        this.discipline,
        this.student
    });

    factory Performance.fromJson(Map<String, dynamic> json) => Performance(
        id: json["id"],
        description: json["description"],
        value: json["value"],
        maxValue: json["max_value"],
        percentage: json["percentage"],
        discipline: Discipline(id: json["discipline"]["id"], name: json["discipline"]["name"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "value": value,
        "max_value": maxValue,
        //"discipline_id": discipline.id,
    };
}