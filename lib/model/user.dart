class User {
  String name;
  String email;
  String password;

  User({this.name, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) => new User(
    name: json["name"],
    email: json["email"],
    password: json["password"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
  };
}

class Singleton {
  static Singleton _instance;
  factory Singleton({User user}) {
    _instance ??= Singleton._internalConstructor(user);
    return _instance;
  }

  Singleton._internalConstructor(this.user);

  User user;
}