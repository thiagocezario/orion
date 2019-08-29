import 'dart:convert';

List<Group> groupFromJson(String str) => new List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Group {
    int id;
    String name;
    int institutionId;
    int courseId;
    int disciplineId;
    String institutionName;
    List<Member> members;

    Group({
        this.id,
        this.name,
        this.institutionId,
        this.institutionName,
        this.courseId,
        this.disciplineId,
        this.members,
    });

    factory Group.fromJson(Map<String, dynamic> json) => new Group(
        id: json["id"],
        name: json["name"],
        institutionId: json["institution_id"],
        institutionName: json["institution_name"],
        courseId: json["course_id"],
        disciplineId: json["discipline_id"],
        members: new List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "institution_id": institutionId,
        "institution_name": institutionName,
        "course_id": courseId,
        "discipline_id": disciplineId,
        "members": new List<dynamic>.from(members.map((x) => x.toJson())),
    };
}

class Member {
    int id;
    String name;

    Member({
        this.id,
        this.name,
    });

    factory Member.fromJson(Map<String, dynamic> json) => new Member(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
    }
]
  """;
}
