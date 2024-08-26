import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/group/group_bloc.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/bloc/users/users_bloc.dart';
import 'package:uep/bloc/working_day/working_day_bloc.dart';
import 'package:uep/core/app.dart';
import 'package:uep/services/auth_service.dart';
import 'package:uep/services/group_service.dart';
import 'package:uep/services/profile_service.dart';
import 'package:uep/services/users_service.dart';
import 'package:uep/services/working_day_service.dart';

void main() {
  final AuthService authService = AuthService();
  final ProfileService profileService = ProfileService();
  final UsersService usersService = UsersService();
  final GroupService groupService = GroupService();
  final WorkingDayService workingDayService = WorkingDayService();

  runApp(
    MultiBlocProvider(
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
        BlocProvider(
          create: (context) =>
              WorkingDayBloc(workingDayService: workingDayService),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
