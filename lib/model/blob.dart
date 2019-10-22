import 'dart:io';

class Blob {
  int id;
  String filename;
  String path;
  String contentType;
  int byteSize;
  File file;

  Blob({this.id, this.filename, this.path, this.contentType, this.byteSize, this.file});

  factory Blob.fromJson(Map<String, dynamic> json) => new Blob(
    id: json["id"],
    filename: json["filename"],
    path: json["path"],
    contentType: json["content_type"],
    byteSize: json["byte_size"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "path": path,
    "content_type": contentType,
    "byte_size": byteSize,
  };
}