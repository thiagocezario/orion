class User {
  int id;
  String name;
  String email;
  String password;

  User({this.id, this.name, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
  };
}

class Singleton {
  static Singleton _instance;
  factory Singleton({User user, String jwtToken}) {
    _instance ??= Singleton._internalConstructor(user, jwtToken);
    return _instance;
  }

  Singleton._internalConstructor(this.user, this.jwtToken);

  User user;
  String jwtToken;
}