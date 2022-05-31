class ProductModel {
  final String? id;
  final String? name;
  final String? type;
  final String? category;
  double? price;
  final String? imageUrl;
  String? size;
  int quantity;

  ProductModel(
      {this.id,
      this.name,
      this.category,
      this.size = 'small',
      this.quantity = 0,
      this.type,
      this.price,
      this.imageUrl});

  factory ProductModel.fromJson(dynamic json) => ProductModel(
        id: json.id,
        name: json["name"],
        category: json["category"],
        type: json["type"],
        price: json["price"].toDouble(),
        imageUrl: json["imageUrl"],
        size: json["size"],
        quantity: json["quantity"],
      );
  factory ProductModel.fromMap(dynamic json) => ProductModel(
        name: json["name"],
        category: json["category"],
        type: json["type"],
        price: json["price"].toDouble(),
        imageUrl: json["imageUrl"],
        size: json["size"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "price": price,
        "imageUrl": imageUrl,
        "category": category,
        "size": size,
        "quantity": quantity,
      };
}
