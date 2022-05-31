import 'package:coffee/constants.dart';
import 'package:coffee/models/my_loader.dart';
import 'package:coffee/models/user_model.dart';
import 'package:coffee/providers/auth_provider.dart';
import 'package:coffee/screens/auth/forgot_password_screen.dart';
import 'package:coffee/screens/auth/sign_up.dart';
import 'package:coffee/screens/auth/widgets/my_text_field.dart';
import 'package:coffee/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _email, _password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Please fill in the details below for sign in',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                hintText: 'Email',
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                hintText: 'Password',
                isPassword: true,
                onChanged: (val) {
                  setState(() {
                    _password = val;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signIn(_email!.trim(), _password!.trim());
                      setState(() {
                        isLoading = false;
                      });
                      Get.to(() => const Homepage());
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
                      : const Text('SIGN IN',
                          style: TextStyle(color: Colors.white)),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account? ',
                      style: TextStyle(fontSize: 13)),
                  InkWell(
                      onTap: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: isLoading
                          ? const MyLoader()
                          : const Text(
                              'Create Account!!',
                              style: TextStyle(color: kPrimary),
                            ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
