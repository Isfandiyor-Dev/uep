import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/users/users_bloc.dart';
import 'package:uep/bloc/users/users_event.dart';
import 'package:uep/bloc/users/users_state.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/widget/shimmer_users_loading.dart';

class AdminsPage extends StatelessWidget {
  const AdminsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Admins"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
          bloc: context.read<UsersBloc>()..add(GetUsers()),
          builder: (context, state) {
            if (state is UsersLoading) {
              return const ShimmerUsersLoading();
            } else if (state is UsersError) {
              return Center(
                child: Scaffold(
                  body: Center(
                    child: Text("Xatolik yuz berdi: ${state.message}"),
                  ),
                ),
              );
            } else if (state is UsersLoaded) {
              List<UserModel> admin =
                  state.users.where((user) => user.roleId == 3).toList();
              return ListView.builder(
                itemCount: admin.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  UserModel userModel = admin[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 35,
                        // backgroundImage: userModel.photo != null
                        //     ? NetworkImage(userModel.photo!)
                        //     : null,
                      ),
                      title: Text(userModel.name),
                      subtitle: Text(userModel.phone),
                    ),
                  );
                },
              );
            } else {
              // Default holat
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
