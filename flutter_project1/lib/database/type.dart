class Type {
  int id;
  String role;

  Type(this.id, this.role);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'role': role,
    };
    return map;
  }

  Type.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    role = map['role'];
  }
}