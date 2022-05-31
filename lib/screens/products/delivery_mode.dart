import 'package:coffee/constants.dart';
import 'package:coffee/models/cart_model.dart';
import 'package:coffee/models/product_model.dart';
import 'package:coffee/providers/cart_provider.dart';
import 'package:coffee/screens/products/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class DeliveryModeScreen extends StatefulWidget {
  const DeliveryModeScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryModeScreen> createState() => _DeliveryModeScreenState();
}

class _DeliveryModeScreenState extends State<DeliveryModeScreen> {
  List<String> options = [
    'Pickup',
    'Delivery',
  ];
  int selectedindex = 0;
  int groupIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: kPrimary,
          child: const Text(
            'Pickup or Delivery',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Would you like your stuff to be PICKED UP or delivered to your place',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 40,
            ),
            ...List.generate(
                options.length,
                (index) => RadioListTile(
                    value: index,
                    groupValue: groupIndex,
                    toggleable: true,
                    contentPadding: EdgeInsets.zero,
                    activeColor: kPrimary,
                    title: Text(options[index]),
                    onChanged: (i) {
                      setState(() {
                        selectedindex = index;
                        groupIndex = index;
                      });
                    })),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Get.to(() => ShippingAddressScreen(
                        pickup: options[selectedindex],
                      ));
                },
                color: kPrimary,
                child: const Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
