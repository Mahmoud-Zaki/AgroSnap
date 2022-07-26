class Product{
  String? id;
  String name,image;
  double price;

  Product({this.id,this.image="",this.name="",this.price=0.0});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"]["\$oid"],
      name: json["name"]??"",
      image: json["image"]??"",
      price: json["price"]??0.0,
    );
  }
}