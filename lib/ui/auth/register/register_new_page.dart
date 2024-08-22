// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/auth/auth_state.dart';
import 'package:uep/utils/validators.dart';
import 'package:uep/ui/auth/widgets/my_signin_button.dart';
import 'package:uep/ui/auth/widgets/my_text_field.dart';
import 'package:uep/ui/screens/home_screen.dart';

enum Role {
  student(["Student", 1]),
  teacher(["Teacher", 2]),
  admin(["Admin", 3]);

  // String qiymatni saqlash uchun maydon
  final List description;

  // Konstruktor
  const Role(this.description);
}

class RegisterNewPage extends StatefulWidget {
  const RegisterNewPage({super.key});

  @override
  State<RegisterNewPage> createState() => _RegisterNewPageState();
}

class _RegisterNewPageState extends State<RegisterNewPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  PhoneNumber phoneNumber = PhoneNumber();

  Role role = Role.student;

  void _onTapRegister() {
    print(_nameController.text);
    print(_passwordController.text);
    print(_confirmPasswordController.text);
    print(phoneNumber);

    if (_formKey.currentState!.validate()) {
      try {
        Map<String, dynamic> data = {
          "name": _nameController.text,
          "phone": phoneNumber.phoneNumber,
          "password": _passwordController.text,
          "password_confirmation": _confirmPasswordController.text,
          "role_id": role.description[1],
        };
        context
            .read<AuthenticationBloc>()
            .add(AuthenticationSignUp(data: data));
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
                height: sreenHeight * 0.9,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PopupMenuButton<Role>(
                            icon: Text("Your role: ${role.description[0]}"),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: Role.student,
                                child: Text("Student"),
                              ),
                              const PopupMenuItem(
                                value: Role.teacher,
                                child: Text("Teacher"),
                              ),
                              const PopupMenuItem(
                                value: Role.admin,
                                child: Text("Admin"),
                              ),
                            ],
                            onSelected: (value) {
                              setState(() {
                                role = value;
                              });
                            },
                          )
                        ],
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
                        controller: _nameController,
                        validator: Validator.validateName,
                        title: "Name",
                        hintText: "Pavel Durov",
                        textInputType: TextInputType.name,
                      ),
                      // Password text field
                      MyTextField(
                        controller: _passwordController,
                        validator: Validator.validatePassword,
                        title: "Password",
                        hintText: "••••••••",
                        textInputType: TextInputType.visiblePassword,
                        isObscurely: true,
                      ),
                      MyTextField(
                        controller: _confirmPasswordController,
                        validator: (value) => Validator.validateConfirmPassword(
                            value, _passwordController.text),
                        title: "Password Confirmation",
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
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state is AuthenticationAuthenticated) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (route) => true,
                            );
                          }
                        },
                        child: InkWell(
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
