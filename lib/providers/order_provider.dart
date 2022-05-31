import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/order_model.dart';
import 'package:flutter/foundation.dart';

final orderRef = FirebaseFirestore.instance.collection('orders');

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => [..._orders];

  Future<void> postOrder(OrderModel order) async {
    await FirebaseFirestore.instance.collection('orders').add(order.toJson());
    notifyListeners();
  }

  Future<void> getOrders() async {
    final results = await FirebaseFirestore.instance.collection('orders').get();

    _orders = results.docs.map((e) => OrderModel.fromJson(e)).toList();
    notifyListeners();
  }
}
