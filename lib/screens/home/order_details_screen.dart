import 'package:coffee/constants.dart';
import 'package:coffee/models/order_model.dart';
import 'package:coffee/screens/home/cart_screen.dart';
import 'package:coffee/screens/home/home_tile.dart';
import 'package:coffee/screens/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: kPrimary,
          child: const Text(
            'OrderDetails',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(
                    order.cart!.products!.length,
                    (index) => CartWidget(
                          product: order.cart!.products![index],
                        )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                myText('Order ID', order.id!),
                myText('Name', order.name!),
                myText('Address', order.address!),
                myText('Pin Code', order.pinCode!),
                myText('City', order.city!),
                myText('Country', order.country!),
                myText('Mode of Pickup', order.pickup!),
                const SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    Get.to(() => PaymentMethod(order: order));
                  },
                  color: kPrimary,
                  textColor: Colors.white,
                  child: const Text('Order again'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget myText(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
        ),
      ]),
    );
  }
}
