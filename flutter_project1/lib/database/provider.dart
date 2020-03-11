class Provider {
  int id;
  String provider;

  Provider(this.id, this.provider);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'provider': provider,
    };
    return map;
  }

  Provider.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    provider = map['provider'];
  }
}