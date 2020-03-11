class User {
  int id;
  String name;
  String email;
  String image;
  String password;
  String lastActive;

  User(this.id, this.name, this.email, this.image,
      this.password, this.lastActive);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'password': password,
      'lastActive': lastActive,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    image = map['image'];
    password = map['password'];
    lastActive = map['lastActive'];
  }
}