import 'package:coffee/constants.dart';
import 'package:coffee/models/my_loader.dart';
import 'package:coffee/models/user_model.dart';
import 'package:coffee/providers/auth_provider.dart';
import 'package:coffee/screens/auth/widgets/my_text_field.dart';
// created
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _email, _password, _username;
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
                'Create an account',
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
                hintText: 'Username',
                onChanged: (val) {
                  setState(() {
                    _username = val;
                  });
                },
              ),
              const SizedBox(
                height: 10,
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
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () async {
                    final user = UserModel(
                      email: _email!.trim(),
                      password: _password!.trim(),
                      userName: _username,
                    );
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signUp(user);
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
                  