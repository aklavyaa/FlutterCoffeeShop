import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/constants.dart';
import 'package:coffee/models/product_model.dart';
import 'package:coffee/providers/product_provider.dart';
import 'package:coffee/screens/home/home_tile.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: kPrimary,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: productRef.where('category', isEqualTo: title).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return ListView(
                children: List.generate(
                    docs.length,
                    (index) => HomeTile(
                          product: ProductModel.fromJson(docs[index]),
                        )));
          }),
    );
  }
}
