import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_state.dart';
import 'package:uep/ui/auth/login/login_page.dart';
import 'package:uep/ui/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state is AuthenticationUnauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Authentication Error: ${state.error}')),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            "assets/logo.png",
            width: 150,
            height: 150,
            color: Colors.lightBlue,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
