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
          // Foydalanuvchi authenticationdan o'tgan bo'lsa HomeScreen ga yo'naltirish
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state is AuthenticationUnauthenticated) {
          // Foydalanuvchi authenticationdan o'tmagan bo'lsa LoginPage ga yo'naltirish
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else if (state is AuthenticationFailure) {
          // Xato holatini ham shu yerda ko'rib chiqish mumkin
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Authentication Error: ${state.error}')),
          );
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text("Loading"),
        ),
      ), // Yoki Loading ekrani
    );
  }
}
