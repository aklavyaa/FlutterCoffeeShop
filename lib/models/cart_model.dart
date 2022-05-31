import 'package:coffee/models/product_model.dart';

class CartModel {
  List<ProductModel>? products = [];
  double? totalPrice;

  CartModel({this.totalPrice, this.products});

  factory CartModel.fromJson(dynamic json) => CartModel(
        totalPrice: json["totalPrice"],
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPrice": totalPrice,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
