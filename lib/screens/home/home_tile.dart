import 'package:coffee/models/product_model.dart';
import 'package:coffee/screens/products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(
              product: product,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(children: [
          SizedBox(
            height: 120,
            width: 100,
            child: Image.network(product.imageUrl!, fit: BoxFit.cover),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                product.category!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$ ${product.price!.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
