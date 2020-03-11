class User_role {
  int id;
  String uid;
  String rid;

  User_role(this.id, this.uid, this.rid);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'uid': uid,
      'rid': rid,
    };
    return map;
  }

  User_role.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    uid = map['uid'];
    rid = map['rid'];
  }
}