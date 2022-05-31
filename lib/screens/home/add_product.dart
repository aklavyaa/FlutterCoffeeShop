import 'dart:io';

import 'package:coffee/constants.dart';
import 'package:coffee/models/my_loader.dart';
import 'package:coffee/models/product_model.dart';
import 'package:coffee/providers/product_provider.dart';
import 'package:coffee/screens/auth/widgets/my_text_field.dart';
import 'package:coffee/screens/home/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? name, type, category;
  double? price;
  XFile? image;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: kPrimary,
          child: const Text(
            'Add Product',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        MyTextField(
          hintText: 'Name of Coffee',
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
          hintText: 'top or featured',
          onChanged: (val) {
            setState(() {
              type = val;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        MyTextField(
          hintText: 'Category',
          onChanged: (val) {
            setState(() {
              category = val;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        MyTextField(
          hintText: 'Price',
          onChanged: (val) {
            setState(() {
              price = double.parse(val);
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();

                var imageFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  image = imageFile;
                });
              },
              child: Container(
                color: kPrimary.withOpacity(0.2),
                padding: const EdgeInsets.all(20),
                child:
                    const Icon(Icons.camera_alt_outlined, color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 100,
              height: 100,
              child:
                  image == null ? Container() : Image.file(File(image!.path)),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            onPressed: image == null ||
                    price == null ||
                    name == null ||
                    type == null
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      final upload = await FirebaseStorage.instance
                          .ref(
                              'products/images/${DateTime.now().millisecondsSinceEpoch}')
                          .putFile(File(image!.path));
                      final downloadUrl = await upload.ref.getDownloadURL();

                      final product = ProductModel(
                        name: name,
                        type: type!.trim().toLowerCase(),
                        category: category!.trim(),
                        imageUrl: downloadUrl,
                        price: price,
                      );
                      await Provider.of<ProductProvider>(context, listen: false)
                          .postProduct(product);
                      setState(() {
                        isLoading = false;
                      });
                      Get.off(() => const Homepage());
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ));
                    }
                  },
            color: kPrimary,
            child: isLoading
                ? const MyLoader()
                : const Text('POST', style: TextStyle(color: Colors.white)),
          ),
        ),
      ]),
    );
  }
}
