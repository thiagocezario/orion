import 'metadata.dart';

class Student {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    Metadata metadata;
    String email;

    Student({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.metadata,
        this.email,
    });

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        email: json["email"] == null ? null : json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "metadata": metadata == null ? null : metadata.toJson(),
        "email": email == null ? null : email,
    };
}