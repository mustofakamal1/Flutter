class Stock {
  int id;
  String nominal;
  String quantity;
  String price;
  String password;
  String last_update;

  Stock(this.id, this.nominal, this.quantity, this.price,
      this.last_update);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nominal': nominal,
      'quantity': quantity,
      'price': price,
      'last_update': last_update,
    };
    return map;
  }

  Stock.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nominal = map['nominal'];
    quantity = map['quantity'];
    price = map['price'];
    last_update = map['last_update'];
  }
}