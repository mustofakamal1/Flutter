class UserRole {
  int id;
  String uid;
  String rid;

  UserRole(this.id, this.uid, this.rid);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'uid': uid,
      'rid': rid,
    };
    return map;
  }

  UserRole.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    uid = map['uid'];
    rid = map['rid'];
  }
}