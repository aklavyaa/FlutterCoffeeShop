import 'package:coffee/constants.dart';
import 'package:coffee/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            SizedBox(
                height: 200, child: Image.asset('assets/images/coffee.png')),
            const SizedBox(height: 30),
            const Text(
                'Thank you for your order.\nIts under process will notify you when its ready',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Get.offAll(() => const Homepage());
                },
                color: kPrimary,
                child: const Text(
                  'HOME',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
