import 'package:coffee/app_splash.dart';
import 'package:coffee/constants.dart';
import 'package:coffee/firebase_options.dart';
import 'package:coffee/providers/auth_provider.dart';
import 'package:coffee/providers/cart_provider.dart';
import 'package:coffee/providers/order_provider.dart';
import 'package:coffee/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: GetMaterialApp(
        title: 'Coffee App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: kPrimary,
            inputDecorationTheme:
                const InputDecorationTheme(focusColor: kPrimary)),
        home: const AppSplashScreen(),
      ),
    );
  }
}
