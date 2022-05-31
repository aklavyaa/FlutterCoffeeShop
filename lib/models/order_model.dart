import 'package:coffee/models/cart_model.dart';
import 'package:coffee/models/product_model.dart';

class OrderModel {
  final String? id;
  final String? userId;
  final double? amount;
  final String? name;
  final String? address;
  final String? city;
  final String? pinCode;
  final String? country;
  final String? pickup;
  final CartModel? cart;

  OrderModel(
      {this.id,
      this.amount,
      this.name,
      this.address,
      this.userId,
      this.city,
      this.pinCode,
      this.cart,
      this.country,
      this.pickup});

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "address": address,
        "city": city,
        "pinCode": pinCode,
        "country": country,
        "pickup": pickup,
        "cart": cart!.toJson(),
        "userId": userId,
      };

  factory OrderModel.fromJson(dynamic json) => OrderModel(
        id: json.id,
        amount: json["amount"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        pinCode: json["pinCode"],
        country: json["country"],
        pickup: json["pickup"],
        cart: CartModel.fromJson(json["cart"]),
        userId: json["userId"],
      );
}
