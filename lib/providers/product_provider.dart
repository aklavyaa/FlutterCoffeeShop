import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/product_model.dart';
import 'package:flutter/foundation.dart';

final productRef = FirebaseFirestore.instance.collection('products');

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => [...products];

  Future<void> postProduct(ProductModel post) async {
    await FirebaseFirestore.instance.collection('products').add(post.toJson());
    notifyListeners();
  }

  Future<void> getProducts() async {
    final results =
        await FirebaseFirestore.instance.collection('products').get();

    _products = results.docs.map((e) => ProductModel.fromJson(e)).toList();
    notifyListeners();
  }
}
