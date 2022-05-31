import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/constants.dart';
import 'package:coffee/models/product_model.dart';
import 'package:coffee/providers/auth_provider.dart';
import 'package:coffee/providers/product_provider.dart';
import 'package:coffee/screens/auth/login.dart';
import 'package:coffee/screens/home/add_product.dart';
import 'package:coffee/screens/home/cart_icon.dart';
import 'package:coffee/screens/home/category_card.dart';
import 'package:coffee/screens/home/home_card.dart';
import 'package:coffee/screens/home/home_tile.dart';
import 'package:coffee/screens/home/orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<AuthProvider>(context, listen: false).getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Hello',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
                const Spacer(),
                const CartIcon(),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const OrdersScreen());
                  },
                  child: const Icon(Icons.sell_outlined),
                ),
                const SizedBox(width: 10),
                InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => const SignInScreen());
                    },
                    child: const Icon(Icons.logout)),
              ],
            ),
            Text(
              user == null ? 'William' : user.userName!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 210,
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      productRef.where('type', isEqualTo: 'top').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<DocumentSnapshot> docs = snapshot.data!.docs;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: docs
                              .map((e) =>
                                  HomeCard(product: ProductModel.fromJson(e)))
                              .toList()),
                    );
                  }),
            ),
            const SizedBox(height: 40),
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<QuerySnapshot>(
                  future: productRef.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;

                      List finaldocs = [];

                      for (var i = 0; i < docs.length; i++) {
                        if (!finaldocs.contains(docs[i]['category'])) {
                          finaldocs.add(docs[i]['category']);
                        }
                      }

                      return Row(
                          children: finaldocs
                              .map((e) => CategoryCard(
                                    amount: docs
                                        .where((element) =>
                                            element['category'] == e)
                                        .length
                                        .toString(),
                                    title: e,
                                  ))
                              .toList());
                    }

                    return Row(
                      children: const [
                        CategoryCard(),
                        CategoryCard(),
                        CategoryCard(),
                        CategoryCard(),
                      ],
                    );
                  }),
            ),
            const SizedBox(height: 40),
            const Text(
              'Featured Beverages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    productRef.where('type', isEqualTo: 'featured').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                  return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                          docs.length,
                          (index) => HomeTile(
                                product: ProductModel.fromJson(docs[index]),
                              )));
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: kPrimary,
          onPressed: () {
            Get.to(() => const AddProductScreen());
          }),
    );
  }
}
