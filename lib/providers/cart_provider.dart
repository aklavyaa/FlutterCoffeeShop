import 'package:coffee/models/cart_model.dart';
import 'package:coffee/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  CartModel? _cart;

  CartModel? get cart => _cart;

  double getTotalPrice() {
    double totalPrice = 0;
    if (_cart != null) {
      for (var product in _cart!.products!) {
        totalPrice += product.price! * product.quantity;
      }
    }
    return totalPrice;
  }

  int quantity = 0;

  void addToCart(ProductModel product) {
    if (_cart == null) {
      _cart = CartModel(
        totalPrice: product.price,
        products: [product],
      );
      quantity = 1;
    } else {
      _cart!.products!
              .where((e) => product.id == e.id && product.size == e.size)
              .isNotEmpty
          ? _cart!.products!
              .firstWhere((element) =>
                  element.size == product.size && element.id == product.id)
              .quantity++
          : _cart!.products!.add(product);
      _cart!.totalPrice = _cart!.totalPrice! + product.price!;

      quantity++;
    }
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    if (_cart!.products!.contains(product)) {
      _cart!.products!.firstWhere((element) => element == product).quantity--;
      quantity--;

      _cart!.totalPrice = _cart!.totalPrice! - product.price!;

      if (_cart!.products!
              .firstWhere((element) => element == product)
              .quantity ==
          0) {
        _cart!.products!.remove(product);
      }
    }

    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    if (_cart!.products!.contains(product)) {
      _cart!.products!.remove(product);
      quantity = quantity - product.quantity;
      _cart!.totalPrice =
          _cart!.totalPrice! - product.price! * product.quantity;
      _cart!.totalPrice! < 0 ? _cart!.totalPrice != 0 : _cart!.totalPrice!;
    }

    notifyListeners();
  }

  void clearCart() {
    _cart = null;
    quantity = 0;
    notifyListeners();
  }
}
