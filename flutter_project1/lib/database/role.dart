class Role {
  int id;
  String role;

  Role(this.id, this.role);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'role': role,
    };
    return map;
  }

  Role.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    role = map['role'];
  }
}