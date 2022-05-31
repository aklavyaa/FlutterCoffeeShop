import 'package:coffee/constants.dart';
import 'package:coffee/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, this.title, this.amount}) : super(key: key);
  final String? title, amount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductsScreen(
              title: title!,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 35),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 0),
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            SizedBox(height: 30, child: Image.asset('assets/images/cof.png')),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(
                  title ?? 'Beverages',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${amount ?? '2'} Menus',
                  style: const TextStyle(
                    color: kPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
