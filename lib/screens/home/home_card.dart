import 'package:coffee/constants.dart';
import 'package:coffee/models/product_model.dart';
import 'package:coffee/screens/products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: kPrimary, borderRadius: BorderRadius.circular(20)),
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Column(children: [
            SizedBox(
              height: 100,
              child: Image.network(
                product.imageUrl!,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '\$' + product.price!.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
