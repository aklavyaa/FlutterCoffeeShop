import 'package:coffee/constants.dart';
import 'package:coffee/models/product_model.dart';
import 'package:coffee/providers/cart_provider.dart';
import 'package:coffee/screens/products/delivery_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: kPrimary,
          child: const Text(
            'Your Cart',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        Expanded(
            child: ListView(
          children: List.generate(
              cart.cart == null ? 0 : cart.cart!.products!.length,
              (index) => Dismissible(
                    key: Key(cart.cart!.products![index].id!),
                    onDismissed: (direction) {
                      cart.removeProduct(cart.cart!.products![index]);
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'Remove',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    child: CartWidget(
                      product: cart.cart!.products![index],
                    ),
                  )),
        )),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      cart.clearCart();
                    },
                    child: const Text(
                      'Clear Cart',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    cart.cart == null
                        ? '\$ 0'
                        : '\$${cart.getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: cart.cart == null || cart.getTotalPrice() < 1
                      ? null
                      : () async {
                          Get.to(() => const DeliveryModeScreen());
                        },
                  color: kPrimary,
                  child: Text(
                    cart.cart == null
                        ? 'Proceed to Checkout'
                        : 'Proceed to Checkout (\$${cart.getTotalPrice().toStringAsFixed(2)})',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl!),
      ),
      title: Text(product.name!),
      subtitle: Text('Quantity: ${product.quantity}'),
      trailing:
          Text('\$${(product.price! * product.quantity).toStringAsFixed(2)}'),
    );
  }
}
