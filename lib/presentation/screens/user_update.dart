import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user_update/user_update_bloc.dart';
import '../../blocs/user_update/user_update_event.dart';
import '../../blocs/user_update/user_update_state.dart';

class UserUpdatePage extends StatelessWidget {
  const UserUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserUpdateBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Update'),
        ),
        body: BlocListener<UserUpdateBloc, UserUpdateState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is UserUpdateFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<UserUpdateBloc, UserUpdateState>(
            builder: (context, state) {
              if (state is UserUpdateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      const TextField(
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      const TextField(
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Use your actual input fields to get values
                          BlocProvider.of<UserUpdateBloc>(context).add(
                            const SubmitUserUpdate(
                              'name',
                              'email@example.com',
                              'address',
                            ),
                          );
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
