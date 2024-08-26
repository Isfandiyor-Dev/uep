import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/auth/auth_state.dart';
import 'package:uep/bloc/group/group_bloc.dart';
import 'package:uep/bloc/group/group_event.dart';
import 'package:uep/bloc/group/group_state.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/bloc/profile/profile_event.dart';
import 'package:uep/bloc/profile/profile_state.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/widget/drawer_widget.dart';
import 'package:uep/ui/admin/widget/shimmer_users_loading.dart';
import 'package:uep/ui/auth/login/login_page.dart';
import 'package:uep/ui/screens/profile/profile_page.dart';
import 'package:uep/ui/screens/widgets/shimmer_profile_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: context.read<ProfileBloc>()..add(LoadProfile()),
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const ShimmerLoading();
        } else if (state is ProfileError) {
          return Center(
            child: Scaffold(
              body: Center(
                child: Text("Xatolik yuz berdi: ${state.message}"),
              ),
            ),
          );
        } else if (state is ProfileLoaded) {
          UserModel userModel = state.user;

          return Scaffold(
            drawer: userModel.role.id == 3 ? const AdminDrawer() : null,
            appBar: AppBar(
              title: const Text("Home"),
              centerTitle: true,
              toolbarHeight: 80,
              automaticallyImplyLeading: userModel.role.id == 3 ? true : false,
              actions: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationUnauthenticated) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(AuthenticationLoggedOut());
                    },
                    icon: const Icon(Icons.logout_rounded),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfilePage(userModel: userModel),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${userModel.name}'),
                    Text('Phone: ${userModel.phone}'),
                    Text('Role: ${userModel.role.name}'),
                    const SizedBox(height: 20),
                    BlocBuilder<GroupBloc, GroupState>(
                      bloc: context.read<GroupBloc>()..add(GetStudentGroups()),
                      builder: (context, state) {
                        if (state is GroupLoading) {
                          return const ShimmerUsersLoading();
                        } else if (state is GroupError) {
                          return Center(
                            child: Text("Xatolik yuz berdi: ${state.message}"),
                          );
                        } else if (state is GroupLoaded) {
                          List<Group> groups = state.groups;
                          return SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                              itemCount: groups.length,
                              itemBuilder: (context, index) {
                                Group group = groups[index];
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(15),
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 35,
                                    ),
                                    title: Text(group.name),
                                    subtitle: Text(group.createdAt.toString()),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          // Default holat
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Default holat
          return const SizedBox.shrink();
        }
      },
    );
  }
}
