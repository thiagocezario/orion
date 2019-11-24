// To parse this JSON data, do
//
//     final absence = absenceFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/user.dart';

import 'discipline.dart';

List<Absence> absenceFromJson(String str) =>
    new List<Absence>.from(json.decode(str).map((x) => Absence.fromJson(x)));

String absenceToJson(List<Absence> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Absence {
  int id;
  int quantity;
  DateTime date;
  int year;
  Discipline discipline;
  User student;

  Absence({
    this.id,
    this.quantity,
    this.date,
    this.year,
    this.discipline,
    this.student,
  });

  factory Absence.fromJson(Map<String, dynamic> json) => Absence(
        id: json["id"],
        quantity: json["quantity"],
        date: DateTime.parse(json["date"]),
        year: json["year"],
        discipline: Discipline(
          id: json["discipline"]["id"],
          name: json["discipline"]["name"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity.toString(),
        "date": date.toIso8601String,
        "year": year.toString(),
      };
}
