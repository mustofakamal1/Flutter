class Stock {
  int id;
  String nominal;
  String quantity;
  String price;
  String password;
  String lastUpdate;

  Stock(this.id, this.nominal, this.quantity, this.price,
      this.lastUpdate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nominal': nominal,
      'quantity': quantity,
      'price': price,
      'lastUpdate': lastUpdate,
    };
    return map;
  }

  Stock.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nominal = map['nominal'];
    quantity = map['quantity'];
    price = map['price'];
    lastUpdate = map['lastUpdate'];
  }
}