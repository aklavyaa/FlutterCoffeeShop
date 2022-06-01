import 'package:flutter/material.dart';

// created and updated by gurwinder
class MyTextField extends StatefulWidget {
  const MyTextField(
      {Key? key, this.hintText, this.onChanged, this.isPassword = false})
      : super(key: key);

  final String? hintText;
  final Function(String val)? onChanged;
  final bool isPassword;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isVisible && widget.isPassword,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? InkWell(
                child: Icon(
                  isVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              )
            : null,
      ),
      onChanged: (val) {
        setState(() {
          widget.onChanged!(val);
        });
      },
    );
  }
}
