import 'package:coffee/providers/cart_provider.dart';
import 'package:coffee/screens/home/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final quantity = Provider.of<CartProvider>(context).quantity;
    return GestureDetector(
      onTap: () {
        Get.to(() => CartScreen());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            color: color ?? Colors.black,
          ),
          Positioned(
            top: -5,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                quantity.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
