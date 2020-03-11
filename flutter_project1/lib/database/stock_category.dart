class Stock_category{
  int id;
  String uid;
  String rid;

  Stock_category(this.id, this.uid, this.rid);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'uid': uid,
      'rid': rid,
    };
    return map;
  }

  Stock_category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    uid = map['uid'];
    rid = map['rid'];
  }
}