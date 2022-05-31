import 'package:coffee/constants.dart';
import 'package:coffee/models/my_loader.dart';
import 'package:coffee/models/user_model.dart';


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
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}
