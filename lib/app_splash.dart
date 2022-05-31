import 'package:coffee/providers/auth_provider.dart';
import 'package:coffee/screens/auth/login.dart';
import 'package:coffee/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      Future.delayed(Duration.zero, () async {
        await Provider.of<AuthProvider>(context, listen: false).getUser();
      });
    }
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => FirebaseAuth.instance.currentUser == null
          ? const SignInScreen()
          : const Homepage());
    });
  }

  @override
  
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Image.asset(
          'assets/images/splash.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
