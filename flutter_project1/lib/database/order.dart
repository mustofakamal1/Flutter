class Order {
  int id;
  String number;
  String pid;
  String jid;
  String nominal;
  String orderDate;

  Order(this.id, this.number, this.pid, this.jid,
      this.nominal, this.orderDate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'number': number,
      'pid': pid,
      'jid': jid,
      'nominal': nominal,
      'orderDate': orderDate,
    };
    return map;
  }

  Order.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    number = map['number'];
    pid = map['pid'];
    jid = map['jid'];
    nominal = map['nominal'];
    orderDate = map['orderDate'];
  }
}