import 'package:coffee/constants.dart';
import 'package:coffee/screens/auth/widgets/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// updated
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Please enter the email id below.\nLink wil be sent to your id to reset it',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  hintText: 'Email Id',
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email!);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: const Text('Link sent to your email id'),
                      ));
                    },
                    color: kPrimary,
                    child: const Text('SUBMIT',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
