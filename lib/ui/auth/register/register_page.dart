// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uep/ui/auth/widgets/my_pinput_widget.dart';
import 'package:uep/ui/auth/widgets/my_signin_button.dart';
import 'package:uep/ui/auth/widgets/my_text_field.dart';
import 'package:uep/ui/auth/widgets/my_warring_box.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onTapRegister() {}

  @override
  Widget build(BuildContext context) {
    double sreenWidth = MediaQuery.of(context).size.width;
    double sreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 25, top: 30),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    color: const Color(0xff3A89FF),
                  ),
                  const Text(
                    "Universal Education Platform",
                    style: TextStyle(
                      fontSize: 19,
                      color: Color(0xff3A89FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: sreenWidth * 0.90,
                height: sreenHeight,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffC4CBD6).withOpacity(0.1),
                      blurRadius: 58,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Valid your phone",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(
                            color: Color(0xff7D8592),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // This is Phone number field
                      InternationalPhoneNumberInput(
                        onInputChanged: (value) {
                          print("Telefon Raqam: $value");
                        },
                        inputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      // This is pin code
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Code from SMS",
                          style: TextStyle(
                            color: Color(0xff7D8592),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const MyPinputWidget(),
                      const MyWarringBox(),
                      const SizedBox(height: 10),
                      // Email text field
                      MyTextField(
                        controller: _emailController,
                        validator: (value) {
                          return null;
                        },
                        title: "Email Address",
                        hintText: "youremail@gmail.com",
                        textInputType: TextInputType.emailAddress,
                      ),
                      // Password text field
                      MyTextField(
                        controller: _passwordController,
                        validator: (value) {
                          return null;
                        },
                        title: "Password",
                        hintText: "••••••••",
                        textInputType: TextInputType.visiblePassword,
                        isObscurely: true,
                      ),

                      // Remember me and Forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  value: true,
                                  onChanged: (value) {},
                                  fillColor: WidgetStatePropertyAll(
                                    Colors.lightBlue[700],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color(0xff7D8593),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Sign In Button
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: _onTapRegister,
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xff3F8CFF),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff3F8CFF).withOpacity(0.5),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.navigate_next_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MySignInButton(
                            imagePath: "assets/google.svg",
                          ),
                          SizedBox(width: 15),
                          MySignInButton(
                            imagePath: "assets/facebook.svg",
                          ),
                          SizedBox(width: 15),
                          MySignInButton(
                            imagePath: "assets/github.svg",
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Do you have an account?",
                          style: TextStyle(
                            color: Color(0xff3F8CFF),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
