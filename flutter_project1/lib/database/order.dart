class User {
  int id;
  String number;
  String pid;
  String jid;
  String nominal;
  String order_date;

  User(this.id, this.number, this.pid, this.jid,
      this.nominal, this.order_date);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'number': number,
      'pid': pid,
      'jid': jid,
      'nominal': nominal,
      'order_date': order_date,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    number = map['number'];
    pid = map['pid'];
    jid = map['jid'];
    nominal = map['nominal'];
    order_date = map['order_date'];
  }
}