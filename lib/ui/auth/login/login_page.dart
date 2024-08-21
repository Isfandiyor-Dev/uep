// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/auth/auth_state.dart';
import 'package:uep/ui/auth/register/register_new_page.dart';
import 'package:uep/utils/validators.dart';
import 'package:uep/ui/auth/widgets/my_signin_button.dart';
import 'package:uep/ui/auth/widgets/my_text_field.dart';
import 'package:uep/ui/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  PhoneNumber phoneNumber = PhoneNumber();

  void _onTapLogin() {
    print(_passwordController.text);
    print(phoneNumber);

    if (_formKey.currentState!.validate()) {
      try {
        Map<String, dynamic> data = {
          "phone": phoneNumber.phoneNumber,
          "password": _passwordController.text,
        };
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationSignIn(data: data));
      } catch (e) {
        print('Xatolik yuz berdi: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double sreenWidth = MediaQuery.of(context).size.width;
    double sreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
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
                height: sreenHeight * 0.7,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
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
                        "Sign In to Woorkroom",
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
                          phoneNumber = value;
                        },
                        inputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        validator: Validator.validatePhoneNumber,
                      ),

                      MyTextField(
                        controller: _passwordController,
                        validator: Validator.validatePassword,
                        title: "Password",
                        hintText: "••••••••",
                        textInputType: TextInputType.visiblePassword,
                        isObscurely: true,
                      ),
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
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state is AuthenticationAuthenticated) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _onTapLogin,
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff3F8CFF),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff3F8CFF).withOpacity(0.5),
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign In ",
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
                      ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterNewPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account?",
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
