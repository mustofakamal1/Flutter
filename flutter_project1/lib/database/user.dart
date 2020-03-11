class User {
  int id;
  String name;
  String email;
  String image;
  String password;
  String last_active;

  User(this.id, this.name, this.email, this.image,
      this.password, this.last_active);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'password': password,
      'last_active': last_active,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    image = map['image'];
    password = map['password'];
    last_active = map['last_active'];
  }
}