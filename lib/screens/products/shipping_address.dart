import 'package:coffee/constants.dart';
import 'package:coffee/models/my_loader.dart';
import 'package:coffee/models/order_model.dart';
import 'package:coffee/providers/cart_provider.dart';
import 'package:coffee/screens/auth/widgets/my_text_field.dart';
import 'package:coffee/screens/payment_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({
    Key? key,
    required this.pickup,
  }) : super(key: key);
  final String pickup;

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  String? name, address, city, code, country;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: kPrimary,
          child: const Text(
            'Shipping Address',
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
        child: ListView(children: [
          MyTextField(
            hintText: 'Your Name',
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            hintText: 'Address',
            onChanged: (val) {
              setState(() {
                address = val;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  hintText: 'City',
                  onChanged: (val) {
                    setState(() {
                      city = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: MyTextField(
                  hintText: 'Pincode',
                  onChanged: (val) {
                    setState(() {
                      code = val;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            hintText: 'Country',
            onChanged: (val) {
              setState(() {
                country = val;
              });
            },
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () async {
                final order = OrderModel(
                  name: name,
                  address: address,
                  city: city,
                  pinCode: code,
                  country: country,
                  pickup: widget.pickup,
                  amount: cart.getTotalPrice(),
                  cart: cart.cart,
                  userId: FirebaseAuth.instance.currentUser!.uid,
                );

                Get.to(() => PaymentMethod(order: order));
              },
              color: kPrimary,
              child: isLoading
                  ? const MyLoader()
                  : const Text(
                      'SUBMIT',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          )
        ]),
      ),
    );
  }
}
