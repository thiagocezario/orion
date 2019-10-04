// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

import 'package:orion/model/discipline.dart';
import 'package:orion/model/institution.dart';

import 'course.dart';
import 'metadata.dart';

List<Group> groupFromJson(String str) => List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Group {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    Metadata metadata;
    Institution institution;
    Course course;
    Discipline discipline;

    Group({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.metadata,
        this.institution,
        this.course,
        this.discipline,
    });

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        institution: json["institution"] == null ? null : Institution.fromJson(json["institution"]),
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
        discipline: json["discipline"] == null ? null : Discipline.fromJson(json["discipline"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "metadata": metadata.toJson(),
        "institution": institution.toJson(),
        "course": course.toJson(),
        "discipline": discipline.toJson(),
    };
}




String getJsonData()  {
  return """[
    {
      "id": 3,
      "name": "TCC 1 - Fight Club",
      "institution_name": "UFPR",
      "institution_id": 7,
      "course_id": 3,
      "discipline_id": 11,
      "members": [
        {
          "id": 1,
          "name": "Thiago"
        },
        {
          "id": 2,
          "name": "Luiz"
        },
        {
          "id": 3,
          "name": "Marcos"
        }
      ]
    },
    {
      "id": 12,
      "name": "TCC 2 - Agora vai",
      "institution_id": 7,
      "institution_name": "UFSC",
      "course_id": 4,
      "discipline_id": 11,
      "members": [
        {
          "id": 1,
          "name": "Thiago"
        },
        {
          "id": 2,
          "name": "Luiz"
        },
        {
          "id": 3,
          "name": "Marcos"
        }
      ]
    },
    {
      "id": 3,
      "name": "Gestão de empresas",
      "institution_name": "Universidade Federal do Paraná",
      "institution_id": 7,
      "course_id": 3,
      "discipline_id": 11,
      "members": [
        {
          "id": 1,
          "name": "Thiago"
        },
        {
          "id": 2,
          "name": "Luiz"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        }
      ]
    },
    {
      "id": 3,
      "name": "Introdução à programação de computadores",
      "institution_name": "Universidade Federal de Minas Gerais",
      "institution_id": 7,
      "course_id": 3,
      "discipline_id": 11,
      "members": [
        {
          "id": 1,
          "name": "Thiago"
        },
        {
          "id": 2,
          "name": "Luiz"
        }
      ]
    },
    {
      "id": 12,
      "name": "Tópicos especiais em bancos de dados",
      "institution_id": 7,
      "institution_name": "Universidade Estadual de Ponta Grossa",
      "course_id": 4,
      "discipline_id": 11,
      "members": [
        {
          "id": 1,
          "name": "Thiago"
        },
        {
          "id": 2,
          "name": "Luiz"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        }
      ]
    },
    {
      "id": 12,
      "name": "Arquitetura de computadores",
      "institution_id": 7,
      "institution_name": "Universidade Federal do Paraná",
      "course_id": 4,
      "discipline_id": 11,
      "members": [
        {
          "id": 1,
          "name": "Thiago"
        },
        {
          "id": 2,
          "name": "Luiz"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        },
        {
          "id": 3,
          "name": "Marcos"
        }
      ]
    },
    {
      "id": 12,
      "name": "Direito Aplicado",
      "institution_id": 7,
      "institution_name": "Universidade Federal do Paraná",
      "course_id": 4,
      "discipline_id": 11,
      "members": [
        {
          "id": 1,
          "name": "Thiago"
        },
        {
          "id": 2,
          "name": "Luiz"
        },
        {
          "id": 3,
          "name": "Marcos"
        }
      ]
    }
]
  """;
}
