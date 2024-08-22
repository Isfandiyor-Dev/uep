import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/group/group_bloc.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/bloc/users/users_bloc.dart';
import 'package:uep/services/auth_service.dart';
import 'package:uep/services/group_service.dart';
import 'package:uep/services/profile_service.dart';
import 'package:uep/services/users_service.dart';
import 'package:uep/ui/intro/splash_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AuthService authService = AuthService();
  final ProfileService profileService = ProfileService();
  final UsersService usersService = UsersService();
  final GroupService groupService = GroupService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(authService)
            ..add(
              AuthenticationStarted(),
            ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            profileService: profileService,
          ),
        ),
        BlocProvider(
          create: (context) => UsersBloc(usersService: usersService),
        ),
        BlocProvider(
          create: (context) => GroupBloc(groupService: groupService),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
