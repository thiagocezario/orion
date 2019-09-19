class User {
  String name;
  String email;
  String password;

  User({this.name, this.email, this.password});
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