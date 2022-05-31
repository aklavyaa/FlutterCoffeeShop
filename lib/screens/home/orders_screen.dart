import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/constants.dart';
import 'package:coffee/models/order_model.dart';
import 'package:coffee/providers/order_provider.dart';
import 'package:coffee/screens/home/order_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: kPrimary,
          child: const Text(
            'Orders',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final order = OrderModel.fromJson(docs[index]);
                return OrderWidget(order: order);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        stream: orderRef
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => OrderDetailsScreen(order: order));
      },
      leading: CircleAvatar(
          backgroundImage: NetworkImage(order.cart!.products!.first.imageUrl!)),
      title: Text('Order #' + order.id!),
      subtitle: Text('Quantity: x${order.address!}'),
      trailing: Text('\$${order.amount!}'),
    );
  }
}
