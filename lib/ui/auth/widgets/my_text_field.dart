import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextInputType textInputType;
  final bool isObscure;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    this.isObscure = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff7D8592),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: textInputType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Color(0xff7D8592),
            ),
            suffixIcon: isObscure
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.eye_slash_fill),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
