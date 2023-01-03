class Product {
  Product({
   required this.id,
   required this.mass,
   required this.money,
   required this.name,
  });

  int id;
  double mass;
  double money;
  // int score;
  String name;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    mass: double.parse(json["mass"].toString()),
    money: json["money"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mass": mass,
    "money": money,
    "name": name,
  };
}
